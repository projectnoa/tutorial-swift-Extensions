import UIKit

class Car {
    enum Condition {
        case new
        case excellent
        case good
        case fair
        case poor
        
        func description() -> String {
            switch self.hashValue {
            case 0:
                return "New"
            case 1:
                return "Excellent"
            case 2:
                return "Good"
            case 3:
                return "Fair"
            case 4:
                return "Poor"
            default:
                return "Good"
            }
        }
    }
    
    private let maker: String?
    private let model: String?
    private var color: UIColor?
    private var condition: Condition?
    private var milleage: Int?
    private let builtAt: Date?
    private let price: Float?
    
    init(maker: String, model: String, color: UIColor, condition: Condition, milleage: Int, builtAt: Date?, price: Float?) {
        self.maker = maker
        self.model = model
        self.color = color
        self.condition = condition
        self.milleage = milleage
        self.builtAt = builtAt
        self.price = price
    }
    
    func getMaker() -> String? {
        return maker
    }
    
    func getModel() -> String? {
        return model
    }
    
    func getColor() -> String? {
        return color?.description
    }
    
    func getCondition() -> String? {
        return condition?.description()
    }
    
    func getMilleage() -> String? {
        return "\(String(describing: milleage))"
    }
    
    func getBuiltDate() -> String? {
        return builtAt?.formatted(date: .abbreviated, time: .omitted)
    }
    
    func getPrice() -> Float? {
        return price
    }
}

let formatter = DateFormatter()
formatter.dateFormat = "dd/MM/yyyy"

var usedCar = Car(maker: "Honda",
                  model: "Civic",
                  color: .red,
                  condition: .good,
                  milleage: 15_000,
                  builtAt: formatter.date(from: "01/01/1999"),
                  price: 2500)

usedCar.getMaker()
usedCar.getModel()
usedCar.getColor()
usedCar.getCondition()
usedCar.getMilleage()
usedCar.getBuiltDate()

protocol BulkPricing {
    func amortizeCar() -> Float
}

extension Car: BulkPricing {
    func amortizeCar() -> Float {
        return amortizedPrice()
    }
    
    func amortizedPrice() -> Float {
        var conditionMultiplier = 5
        
        switch condition {
        case .new:
            conditionMultiplier = 5
            break
        case .excellent:
            conditionMultiplier = 4
            break
        case .good:
            conditionMultiplier = 3
            break
        case .fair:
            conditionMultiplier = 2
            break
        case .poor:
            conditionMultiplier = 1
            break
        default:
            conditionMultiplier = 5
            break
        }
        
        var dateMultiplier = 5
        
        let yearsSinceMade = builtAt!.distance(to: Date())
        
        switch yearsSinceMade {
        case 0:
            dateMultiplier = 5
            break
        case 1..<5:
            dateMultiplier = 4
            break
        case 5..<10:
            dateMultiplier = 3
            break
        case 10..<20:
            dateMultiplier = 2
            break
        default:
            dateMultiplier = 1
            break
        }
        
        return price! - (price! * Float(conditionMultiplier + dateMultiplier) / 100)
    }
}

usedCar.amortizedPrice()
