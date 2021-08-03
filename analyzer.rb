class LineAnalyzer

    def initialize(line, text)
        @line = line
        @text = text
    end

    def analyze()
        words = Hash.new {0}
        repeat_words = Array.new

        @text.split.each { |word|
            words[word] += 1
        }
        words.keys.each { |key| 
            if words[key] == words.values.max and not ['ao', 'na', 'que', 'A', 'só', 'com', 'à', 'às', 'os', 'o', 'para', 'das', 'a', 'e', 'de', 'do', 'em', 'da', 'os', 'as'].include?(key) then
                repeat_words.push([key, words[key], @line])
            end
        }
        return repeat_words
    end
end

all_lines_analyzed = Array.new
File.open('manifesto-do-partido-comunista.txt', 'r') do |fp|
    count = 0
    while line = fp.gets
        all_lines_analyzed.push(LineAnalyzer.new(count, line))
        count += 1
    end
end

all_lines_analyzed.each { |value|
    value.analyze().each { |line|
        if line[1] > 1 then
            puts "line: #{line[2]} | #{line[0]} | #{line[1]}"
        end
    }
}
