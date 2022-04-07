class ApplicationController < ActionController::Base
    def goodbye
        render html: "Goodbye World!"
    end
end
