require "mailjet_spec_helper"

RSpec.describe Mailjet::ApiError do
  context "JSON response body" do
    it "does not throw error" do
      expect {
        Mailjet::ApiError.new(404, "{}", "request details", "example.com/resource", {})
      }.to_not raise_error
    end

    it "parses JSON string" do
      response = '{"ErrorInfo": "", "ErrorMessage": "Object not found", "StatusCode": 404}'

      exception = Mailjet::ApiError.new(404, response, "request details", "example.com/resource", {})

      expect(exception.code).to eq 404
      expect(exception.reason).to eq "Object not found"
      expect(exception.message).to eq <<-MESSAGE
error 404 while sending "request details" to example.com/resource with {}

"{\\"ErrorInfo\\": \\"\\", \\"ErrorMessage\\": \\"Object not found\\", \\"StatusCode\\": 404}"

Please see https://dev.mailjet.com/guides/#status-codes for more informations on error numbers.

MESSAGE
    end
  end

  context "non JSON response body" do
    it "throws an error" do
      response = "<html>\r\n<head><title>404 Not Found</title></head>\r\n<body bgcolor=\"white\">\r\n<center><h1>404
        Not Found</h1></center>\r\n<hr><center>nginx</center>\r\n</body>\r\n</html>\r\n"

      expect {
        Mailjet::ApiError.new(404, response, "request details", "example.com/resource", {})
      }.to raise_error ActiveSupport::JSON.parse_error
    end
  end
end
