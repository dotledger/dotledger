namespace :rahani do
  desc "Import transactions from an OFX file"
  task :import, [:account_id, :file] => :environment do |t, args|
    begin
      account = Account.find(args[:account_id])
      ofx_file = File.open(args[:file])

      creator = StatementCreator.new(:account => account, :file => ofx_file)

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
end
