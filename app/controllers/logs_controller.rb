class LogsController <ApplicationController

    def index
    
    @logs = HTTParty.get('http://localhost:3000/logs').parsed_response
   
    end

end