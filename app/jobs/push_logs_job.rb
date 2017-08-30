class PushLogsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    
    data = args.first
    #binding.pry
    ap data
    HTTParty.post('http://localhost:3000/logs',{body: {log: data}})
  end
end
