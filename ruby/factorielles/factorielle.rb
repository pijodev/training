puts "---------------------------"
puts "         FACTORIELLE"
puts "---------------------------"

puts "Donnez un entier en entrée du script et observez son appel NON récursif"
puts ""
puts "~~~~"
puts ""
n = ARGV[0].to_i

def calculFacto(n)
    res = 1
    cpt = 0
    while cpt < n
        res = res * (cpt+1)
        cpt += 1
    end

    puts(res)
end

puts ("Factorielle de #{n} =")
calculFacto(n)

# facto 5 = 5 * 4 * 3 * 2 * 1