import Requests

public class ApiBlueprintClient {
	let baseUrlString = "http://api.apiblueprint.org/parser"
	//let baseUrlString = "http://httpbin.org/post"

	public init() {
	}

	private var headers: [(String, String)] {
		return [
			("Content-Type", "text/vnd.apiblueprint"),
			("Accept", "application/vnd.refract.parse-result+json"),
		]
	}

	public func parse(blueprint: String) throws -> String {
		let response = try request(method: "POST", url: baseUrlString, headers: headers, body: blueprint)
		if response.status.code != 200 && response.status.code != 422 {
			throw Errors.UnsucessfulRequest(statusCode: response.status.code)
		}
		return response.body ?? ""
	}
}