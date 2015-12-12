#if os(Linux)
import Glibc
#else
import Darwin.C
#endif

import Requests

public class ApiaryClient {
	private let baseUrlString = "http://api.apiary.io/blueprint/get/"
	private let token: String

	private var headers: [(String, String)] {
		return [
			("Authentication", "Token \(token)"),
			("Accept", "*/*"),
		]
	}

	public init() throws {
		if let token = String.fromCString(getenv("APIARY_API_KEY")) {
			self.token = token
		} else {
			throw Errors.NoApiaryToken
		}
	}

	public func fetch(apiName: String) throws -> String {
		let response = try get(baseUrlString + apiName, headers: headers)
		if response.status.code != 200 {
			throw Errors.UnsucessfulRequest(statusCode: response.status.code)
		}
		return response.body ?? ""
	}
}
