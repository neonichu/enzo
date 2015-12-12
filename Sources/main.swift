import Commander
import Decodable
import Foundation

enum Errors: ErrorType {
    case InvalidJSON
    case NoApiaryToken
    case UnsucessfulRequest(statusCode: Int)
}

private func json(data: String) throws -> AnyObject? {
    if let data = data.dataUsingEncoding(NSUTF8StringEncoding) {
      return try NSJSONSerialization.JSONObjectWithData(data, options: [])
    }
    return nil
}

Group {
  $0.command("parse") { (apiName: String) in
    let apiaryClient = try ApiaryClient()
    guard let apiary_json = try json(apiaryClient.fetch(apiName)) else {
      throw Errors.InvalidJSON
    }

    var blueprint: String = try apiary_json => "code"

    // FIXME: for testing of "invalid" blueprint
    //blueprint = blueprint.stringByReplacingOccurrencesOfString("[object]", withString: "")
    //var blueprint = try NSString(contentsOfFile: "Tests/Fixtures/yolo.apib", encoding:NSUTF8StringEncoding) as String
    
    let blueprintApiClient = ApiBlueprintClient()
    guard let bpjson = try json(blueprintApiClient.parse(blueprint)) else {
      throw Errors.InvalidJSON
    }

    if let error = (try bpjson => "error") as? NSDictionary {
      let message = error["message"] ?? "Unknown error"
      print("Could not parse blueprint: \(message!)")
      exit(2)
    }

    if let elements = (try bpjson => "content") as? NSArray {
      var hasWarnings = false

      try elements.forEach { element in
        let meta: [String] = try (element as AnyObject) => "meta" => "classes"
        if meta.first == "warning" {
          print("warning: \(element["content"])")
          hasWarnings = true
        }
      }

      if hasWarnings { exit(1) }
    }

    print("OK")
  }
}.run()
