class OpenStruct
  
  # when asked for id, ruby 1.8.7's implementation of OpenStruct returns object's inner id instead of table's value if present. Evilishish infamous Monkey-Patch.
  if RUBY_VERSION =~ /1\.8\./
    def id
      send(:eval, "@table[:id]")
    end
  end
end