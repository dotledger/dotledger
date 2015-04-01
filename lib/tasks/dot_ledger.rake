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
        puts "Error: #{creator.errors.messages.map { |k,v| "#{k} #{v.join(', ')}." }.join}"
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
    file =
      if args[:file].present?
        File.open(args[:file], 'w')
      else
        $stdout
      end

    exporter = DotLedgerExporter.new(file)
    exporter.export

    summary = "Exported\n--------\n\n"
    exporter.data.each do |label, elements|
      summary << "#{label}: #{elements.count}\n"
    end

    $stderr.write(summary)
  end

  desc 'Import data from a YAML file'
  task :import_yaml, [:file] => :environment do |t, args|
    file =
      if args[:file].present?
        File.open(args[:file], 'r')
      else
        $stdin
      end

    importer = DotLedgerImporter.new(file)
    importer.import

    summary = "Imported\n--------\n\n"
    importer.data.each do |label, elements|
      summary << "#{label}: #{elements.count}\n"
    end

    $stderr.write(summary)
  end
end
