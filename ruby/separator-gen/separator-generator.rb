
def prepareInputs(string)
    if string == 'personalized'
        puts("Quel décorateur voulez-vous utiliser ? Par exemple : * , # , ~, @ ... :")
        # On utilise STDIN car maintenant qu'on peut passer des arguments en entrée du script
        # il faut indiquer qu'on prend l'entrée sur STDIN (clavier) et pas ailleurs
        deco = STDIN.gets().chomp()
    elsif string == 'notPersonalized'
        deco = '#'
    end

    

    puts("Quel est le title de votre séparateur de paragraphe ? ")
    puts("")
    puts(">> CONSEIL : Simple, clair concis et en capitales ça rend bien.")
    title = STDIN.gets().chomp()
    puts("")

    return [deco, title]
end

def concatenor(nb, string)
    layer = ""
    layer.concat('#')

    if string.length() > 0
        nb.times do 
            layer.concat(string)
        end 
    else
        nb.times do 
            layer.concat(" ")
        end 
    end
    layer.concat('#')
    return layer
end

def title_concatenator(total_len, string)
    layer = ""
    layer.concat('#')

    nb_white_spaces = total_len - string.length()

    if nb_white_spaces.even?
        t = nb_white_spaces / 2 
        t.times do 
            layer.concat(" ")
        end 
        layer.concat(string)
        t.times do 
            layer.concat(" ")
        end
    else
        t = (nb_white_spaces / 2) - 1
        t.times do 
            layer.concat(" ")
        end 
        layer.concat(string)
        t.times do 
            layer.concat(" ")
        end
    end

    layer.concat('#')
    return layer
end

def generateSep(deco, title)
    title_len = title.length()

    # Tableau contenant toutes les lignes qu'on veut afficher
    final_sep = []
    
    # Longueur totale des lignes du séparateur
    nb = title_len + 12

    layer = concatenor(nb, deco)

    2.times do 
        final_sep.push(layer)
    end

    # Ligne vide pour la clarté
    empty_lay = concatenor(nb, "")
    final_sep.push(empty_lay)

    # Le titre du separateur
    title_lay = title_concatenator(nb, title)

    # Finalisation de la symétrie horizontale
    final_sep.push(title_lay)
    final_sep.push(empty_lay)

    2.times do 
        final_sep.push(layer)
    end

    puts("")
    puts final_sep 
end


def main(args)

    puts ("Début de la génération du séparateur ... ")
    puts("")

    if args[0].to_s.length() > 0
        inputs = prepareInputs('personalized')
    else
        inputs = prepareInputs('notPersonalized')
    end
    deco = inputs[0]
    title = inputs[1]

    generateSep(deco, title)   

    puts("")
    puts ("Il n'y a plus qu'à copier coller le résultat !")

end

args = ARGV
main(args)