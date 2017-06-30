
import Foundation

struct Badge {
  let name: String
  let imageName: String
  let information: String
  let distance: Double
  
  init?(from dictionary: [String: String]) {
    guard
      let name = dictionary["name"],
      let imageName = dictionary["imageName"],
      let information = dictionary["information"],
      let distanceString = dictionary["distance"],
      let distance = Double(distanceString)
      else
    {
      return nil
    }
    self.name = name
    self.imageName = imageName
    self.information = information
    self.distance = distance
  }
  // 加载badges.txt的数据
  static let allBadges: [Badge] = {
    guard let fileURL = Bundle.main.url(forResource: "badges", withExtension: "txt") else {
      fatalError("No badges.txt file found")
    }
    do {
      let jsonData = try Data(contentsOf: fileURL, options: Data.ReadingOptions.mappedIfSafe)
      let jsonResult = try JSONSerialization.jsonObject(with: jsonData) as! [[String: String]]
      //这是什么写法，这是什么操作？？？
      return jsonResult.flatMap(Badge.init)
    } catch {
      fatalError("Cannot decode badges.txt")
    }
  }()
  
  static func best(for distance: Double) -> Badge {
    return allBadges.filter { $0.distance < distance }.last ?? allBadges.first!
  }
  
  static func next(for distance: Double) -> Badge {
    return allBadges.filter { distance < $0.distance }.first ?? allBadges.last!
  }
}

extension Badge: Equatable {
  static func == (lhs: Badge, rhs: Badge) -> Bool {
    return lhs.name == rhs.name
  }
}
