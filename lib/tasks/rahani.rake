namespace :rahani do
  desc "Import transactions from an OFX file"
  task :import, [:account_id, :file] => :environment do |t, args|
    begin
      account = Account.find(args[:account_id])
      ofx_file = File.open(args[:file])

      transactions = Transaction.import(ofx_file, account)

      puts "Imported #{transactions.count} transactions into #{account.name}."
    rescue StandardError => e
      puts "Error: #{e.message}"
      exit 1
    end
  end
end
