namespace :dot_ledger do
  desc 'Import transactions from an OFX file'
  task :import, [:account_id, :file] => :environment do |t, args|
    begin
      account = Account.find(args[:account_id])
      ofx_file = File.open(args[:file])

      creator = StatementCreator.new(account: account, file: ofx_file)

      if creator.save
        puts "Imported #{creator.statement.transactions.count} transactions into #{account.name}."
      else
        puts "Error: #{creator.errors.messages.map {|k,v| "#{k} #{v.join(', ')}."}.join}"
      end

    rescue StandardError => e
      puts "Error: #{e.message}"
      exit 1
    end
  end

  desc 'Re-run sorting rules on unsorted transactions'
  task sort: :environment do
    count = 0
    Transaction.unsorted.each do |t|
      sorter = TransactionSorter.new(t)
      sorter.sort

      count += 1 if sorter.sorted_transaction.present?
    end

    puts "Sorted #{count} transactions."
  end

  desc 'Export data to a YAML file'
  task :export_yaml, [:file] => :environment do |t, args|
    begin
      data = {}

      data['Accounts'] = Account.all.map do |account|
        account.slice(:name, :number, :type).to_hash
      end

      data['Categories'] = Category.all.map do |category|
        category.slice(:name, :type).to_hash
      end

      data['SortingRules'] = SortingRule.all.map do |sorting_rule|
        sorting_rule.slice(:name, :contains, :category_name).to_hash
      end

      if args[:file].present?
        File.open(args[:file], 'w+') do |f|
          f.write(data.to_yaml)
        end

        puts 'Exported'
        puts '--------'
        data.each do |label, elements|
          puts "#{label}: #{elements.count}"
        end
      else
        puts data.to_yaml
      end
    rescue StandardError => e
      puts "Error: #{e.message}"
      exit 1
    end
  end

  desc 'Import data from a YAML file'
  task :import_yaml, [:file] => :environment do |t, args|
    begin
      counts = {
        'Accounts' => 0,
        'Categories' => 0,
        'SortingRules' => 0
      }

      data = YAML.load_file(args[:file])
      if data['Accounts']
        data['Accounts'].map do |account|
          new_account = Account.where(account).first_or_initialize
          counts['Accounts'] += 1 if new_account.new_record?
          new_account.save!
        end
      end

      if data['Categories']
        data['Categories'].map do |category|
          new_category = Category.where(category).first_or_initialize
          counts['Categories'] += 1 if new_category.new_record?
          new_category.save!
        end
      end

      if data['SortingRules']
        data['SortingRules'].map do |sorting_rule|
          category = Category.where(name: sorting_rule.delete('category_name')).first
          new_sorting_rule = SortingRule.where(
            sorting_rule.merge(category_id: category.id)
          ).first_or_initialize
          counts['SortingRules'] += 1 if new_sorting_rule.new_record?
          new_sorting_rule.save!
        end
      end

      puts 'Imported'
      puts '--------'
      counts.each do |label, count|
        puts "#{label}: #{count}"
      end
    rescue StandardError => e
      puts "Error: #{e.message}"
      exit 1
    end
  end
end
