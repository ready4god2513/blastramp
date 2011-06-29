module ExtString
  def snake_case
    gsub(/\B[A-Z]/, '_\&').downcase
  end
end
String.send(:include, ExtString)
