class Dictionary

  def initialize(file_path)
    self.words = File.read(file_path)
                     .split("\n")
                     .inject({}) { |hash, val| hash[val] = true; hash }
  end

  def valid?(word)
    !words[word].nil?
  end

  private

  attr_accessor :words
end
