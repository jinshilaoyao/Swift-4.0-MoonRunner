
import MapKit

class BadgeAnnotation: MKPointAnnotation {
  let imageName: String
  
  init(imageName: String) {
    self.imageName = imageName
    super.init()
  }
}
