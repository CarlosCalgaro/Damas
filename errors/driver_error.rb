class DriverError < StandardError

    def initialize()
        super("Driver inacessivel!")
    end
    
end