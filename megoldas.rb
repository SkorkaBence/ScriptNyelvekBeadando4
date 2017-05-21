require 'pathname'

if ARGV.length < 1
    puts "Adj meg egy file-t!"
    abort()
end
if ! (File.exist? File.expand_path ARGV[0])
    puts "Nincs ilyen file!"
    abort()
end

$solutions = {}
def get_value (v)
    if $solutions.key?(v)
        return $solutions[v]
    else
        return v.to_i()
    end
end

output = open('eredmeny.txt', 'w')
open(ARGV[0], "r") do |f|
    f.each_line do |line|
        items = line.split(", ")
        nev = items[0]
        func = items[1]
        values = items[2].split(" ")
        values.shift()

        sol = 0

        if func == "max"
            sol = get_value(values[0])
            values.each do |v|
                val = get_value(v)
                if val > sol
                    sol = val
                end
            end
        elsif func == "sum"
            sol = 0
            values.each do |v|
                sol += get_value(v)
            end
        elsif func == "prod"
            sol = 1
            values.each do |v|
                sol *= get_value(v)
            end
        end

        $solutions[nev] = sol
        output.puts "#{nev} = #{sol}"
    end
end
