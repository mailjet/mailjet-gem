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

Please see https://dev.mailjet.com/email/reference/overview/errors/ for more informations on error numbers.

MESSAGE
    end
  end

  context "plain HTML response body" do
    it "does not throws an error" do
      response = "<html></html>"

      expect {
        Mailjet::ApiError.new(404, response, "request details", "example.com/resource", {})
      }.to_not raise_error
    end

    it "adds original body to error message" do
      response = <<-HTML.chomp
<html>
<head><title>404 Not Found</title></head>
<body bgcolor="white">
<center><h1>404 Not Found</h1></center>
<hr><center>nginx</center>
</body>
</html>
HTML

      exception = Mailjet::ApiError.new(404, response, "request details", "example.com/resource", {})

      expect(exception.code).to eq 404
      expect(exception.reason).to eq "<html>\n<head><title>404 Not Found</title></head>\n<body bgcolor=\"white\">\n<center><h1>404 Not Found</h1></center>\n<hr><center>nginx</center>\n</body>\n</html>"
      expect(exception.message).to eq <<-MESSAGE
error 404 while sending "request details" to example.com/resource with {}

"<html>\\n<head><title>404 Not Found</title></head>\\n<body bgcolor=\\"white\\">\\n<center><h1>404 Not Found</h1></center>\\n<hr><center>nginx</center>\\n</body>\\n</html>"

Please see https://dev.mailjet.com/email/reference/overview/errors/ for more informations on error numbers.

MESSAGE
    end
  end
end
