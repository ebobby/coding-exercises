# Design a data structure that supports adding new words and finding if a string matches any previously added string.
# Implement the WordDictionary class:
#
# WordDictionary() Initializes the object.
# void addWord(word) Adds word to the data structure, it can be matched later.
# bool search(word) Returns true if there is any string in the data structure that matches word or false otherwise.
#    word may contain dots '.' where dots can be matched with any letter.Example:
#
# WordDictionary wordDictionary = new WordDictionary();
# wordDictionary.addWord("bad");
# wordDictionary.addWord("dad");
# wordDictionary.addWord("mad");
# wordDictionary.search("pad"); // return False
# wordDictionary.search("bad"); // return True
# wordDictionary.search(".ad"); // return True
# wordDictionary.search("b.."); // return True
# Constraints:
# 1 <= word.length <= 500
# word in addWord consists lower-case English letters.
# word in search consist of  '.' or lower-case English letters.
# At most 50000 calls will be made to addWord and search.

require "test/unit/assertions"
include Test::Unit::Assertions

class WordDictionary
  attr_reader :root_trie

  def initialize
    @root_trie = {}
  end

  def add_word(word)
    trie = root_trie
    word.chars.each do |c|
      trie.merge!(c => {}) unless trie.key?(c)
      trie = trie[c]
    end
    trie[:end] = true
  end

  def search(word)
    internal_search(root_trie, word)
  end

  private

  def internal_search(subtrie, subword)
    return false if subtrie.nil?
    return subtrie.key?(:end) if subword.empty?

    next_char = subword[0]
    rest = subword[1..-1]

    if next_char != "."
      internal_search(subtrie[next_char], rest)
    else
      subtrie.values.any? { |trie| internal_search(trie, rest) }
    end
  end
end


wd = WordDictionary.new

wd.add_word("bad");
wd.add_word("dad");
wd.add_word("mad");

assert_equal wd.search("pad"), false
assert_equal wd.search("bad"), true
assert_equal wd.search(".ad"), true
assert_equal wd.search("b.."), true
