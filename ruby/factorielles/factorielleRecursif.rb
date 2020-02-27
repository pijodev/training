puts "---------------------------"
puts "         FACTORIELLE REC"
puts "---------------------------"

puts "Donnez un entier en entrée du script - appel récursif"
puts ""
puts "~~~~"
puts ""
n = ARGV[0].to_i

def calculFactoRecu(n, cpt)
    res = 1
    cpt = 0

    if (cpt < n)
        res = res * (cpt+1)
        cpt += 1
        calculFactoRecu(res, cpt)
    else 
        puts(res)
        return res
    end

    
end

puts ("Factorielle récursive de #{n} = ")
calculFactoRecu(n, 0)


# facto 5 = 1 * 2 * 3 * 4 * 5