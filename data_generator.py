### Data generators for Enterprise Database


### imports ###########################################################

import random



### Helper Functions for generating various things ####################

def random_phone():
    phone = str(random.randint(1,9)) # can't start with 0
    for i in range(9):
        phone += str(random.randint(0,9))
    return phone

def random_date():
    return "\'"+str(201)+str(random.randint(1,9))+'-'+str(random.randint(1,12))+'-'+str(random.randint(1,28))+"\'"



### Functions for generating insert strings ##################################

def apple_account():
    first_names = ['robert','colton','ryan','jacob','logan']
    last_names = ['utterback','willhardt','mckirdy','mclaughlin','mayfield']
    
    for first in first_names:
        for last in last_names:
            name = "\'"+first+' '+last+"\'"
            email = "\'"+first+last+'@yahoo.com'+"\'"
            balance = str(random.uniform(0,100))
            # 25% chance that balance is zero
            if random.uniform(0,100)>75:
                balance = str(0)

            print('('+email+','+name+','+balance+'),')

def store():
    cities = ['New york','Chicago','San Diego','Miami','St. Louis']
    countries = ['USA','Canada','Mexico','Germany']
    streets = ['Main','Broadway','East','North']

    for city in cities:
        for country in countries:
            address = str(random.randint(100,999))+' '+random.choice(streets)+ ' Street'

            print('('+"\'"+city+"\'"+','+"\'"+country+"\'"+','+"\'"+address+"\'"+'),')

def artist():
    name_pt1 = ['lil ','Taylor ','Capital ','Rolly ','']
    name_pt2 = ['Wayne','Swift','Cities','Polly','Boston']
    artists = []

    for n1 in name_pt1:
        for n2 in name_pt2:
            name = "\'"+n1+n2+"\'"
            artists.append(name)
            email = "\'"+n2+'@yahoo.com'+"\'"
            print('('+name+','+email+','+random_phone()+'),')

    # return if needed elsewhere
    return artists

def song(artists):
    song_names = ['Mars','Monday','Corn','Yes','No']
    album_names = ['Cool Songs','Life','Rainbows']
    songs = []
    for artist_id in range(1,len(artists)-2): # have a few artists with no songs
        num_albums = random.randint(1,3)
        temp_albums = album_names
        for album in range(num_albums):
            album_name = album_names[album]
            num_songs = random.randint(1,4)
            for song in range(num_songs):
                song_name = song_names[song]
                if random.randint(0,100)>50:
                    price = 1.29
                else:
                    price = .99
                print('('+str(artist_id)+','+"\'"+song_name+"\',\'"+album_name+"\',"+str(price)+'),')
                songs.append(song_name)
    return songs

def song_purchases(songs):
    for i in range(1,20):
        song_purchases = random.randint(0,10)
        song_list = []
        for j in range(song_purchases):
            song = random.randint(1,len(songs)-5)
            if song not in song_list: # cant purchase same song twice
                song_list.append(song)
                date = str(201)+str(random.randint(1,9))+'-'+str(random.randint(1,12))+'-'+str(random.randint(1,28))
                if random.randint(0,100)>50:
                    cost = 1.29
                else:
                    cost = .99
                print('('+str(song)+','+str(i)+",\'"+date+"\',"+str(cost)+'),')
    
def developer():
    name1 = ['Epic','Little','Mojang','Awesome']
    name2 = [' Games',' Studios','',' Creations']
    names = []
    for i in name1:
        for j in name2:
            name = i+j
            names.append(name)
            email = "\'"+name+"@yahoo.com"+"\'"
            email2 = ''
            # remove any spaces
            for char in email:
                if char != ' ':
                    email2 += char
            email = email2
            name = "\'"+name+"\'"
            print('('+name+','+email+','+random_phone()+'),')
    return names

def app():
    name1 = ['Hop','Clash','Flappy','Twitter','Pokemon']
    name2 = [' Forever',' Royale',' Bird','',' Go']

    for i in name1:
        for j in name2:
            name = "\'"+i+j+"\'"
            ran = random.randint(1,3)
            if ran == 1: price = 0
            elif ran == 2: price = .99
            else: price = 1.99
            dev_id = random.randint(1,15)
            print('('+name+','+str(price)+','+str(dev_id)+'),')

def app_purchase():
    purchases = []
    for i in range(3,23):
        buys = random.randint(0,10)
        temp = []
        for j in range(buys):
            apple_id = random.randint(5,25)
            ran = random.randint(1,3) # cost can vary from price as prices change
            if ran == 1: cost = 0.59
            elif ran == 2: cost = .99
            else: cost = 1.99
            if apple_id not in temp:
                temp.append(apple_id) # make sure app isnt bought twice by same account
                print('('+str(i)+','+str(apple_id)+','+random_date()+','+str(cost)+'),')
                purchases.append((apple_id,i))
    return purchases

def in_app_items():
    ia_names = ['Skin','Car','Upgrade','Character','Cool Thing']
    ia_consumables = ['Vbucks','Currency','Food','Gems','Elixir']
    ia_list = []
    ia_count = 0
    for i in range(1,25):
        # random chance app has in app items
        if random.randint(1,4) > 2:
            num_inapps = random.randint(1,5)
            for j in range(1,num_inapps):
                ia_count += 1
                # consumable or not
                ia_type = random.choice([True,False])
                ran = random.randint(1,3)
                if ran == 1: price = 0.59
                elif ran == 2: price = .99
                else: price = 1.99
                ia_list.append((ia_count,i,ia_type))
                if ia_type == True:
                    name = random.choice(ia_consumables)
                    ia_list.append((ia_count,i,ia_type))
                    print('('+str(i)+',TRUE,'+str(price)+",\'"+name+"\'),")
                else:
                    print('('+str(i)+',FALSE,'+str(price)+','+"\'"+str(random.choice(ia_names))+",\'"+'),')
    return ia_list

# one can only have an in app purchase if they have also purchased the app which is why im passing lists of tuples around
def in_app_purchases(purchases,ia_list):
    ia_purchases = []
    for i in range(len(purchases)):
        purch = purchases[i]
        for j in range(len(ia_list)):
            cons = ia_list[j]
            if purch[1] == cons[1]:
                if random.randint(1,4)>1:
                    # make sure we dont have a repeat
                    if (purch[0],cons[0],cons[2]) not in ia_purchases:
                        ran = random.randint(1,3)
                        if ran == 1: cost = 0.59
                        elif ran == 2: cost = .99
                        else: cost = 1.99
                        # i should be making sure this date is after app purchase date, but thats too complicated
                        print('('+str(cons[0])+','+str(purch[0])+','+random_date()+','+str(cost)+','+str(random.randint(1,10))+'),')
                        ia_purchases.append((purch[0],cons[0],cons[2]))
    return ia_purchases

# one can have in app items without purhcasing them (free events, gifts, etc etc)
# but if they have bought, then we have to have entry in this table for them
def consumable_ownership(ia_purchases):
    for i in range(len(ia_purchases)):
        purch = ia_purchases[i]
        if purch[2] == True:
            print('('+str(purch[1])+','+str(purch[0])+','+str(random.randint(0,10))+'),')

def vendor():
    countries = ['USA','Canada','Mexico','Germany']
    cities = ['New york','Chicago','San Diego','Miami','St. Louis']
    names = ['Apple','Logitech','DJI','Otterbox']
    ran_name1 = ['Best','Quality','Tough']
    ran_name2 = ['Goods','Tech','Stuff']
    for n in names:
        print("(\'"+n+"\',\'USA\',\'Los Angeles\'),")
    for n1 in ran_name1:
        for n2 in ran_name2:
            name = n1+' '+n2
            print("(\'"+name+"\',\'"+str(random.choice(countries))+"\',\'"+str(random.choice(cities))+"\'),")

def product1():
    names = ['MacBook','MacBook Pro','Mac Mini','iMac','iPhone','iPod','Apple Watch','HomePod'] # 8
    brand = "\'Apple\'"
    prod_type = "\'electronic\'"
    vendor_id = str(1)
    for n in names:
        print('('+"\'"+n+"\',"+brand+','+prod_type+','+vendor_id+'),')
    names = ['Smart Doorbell','Phantom 4','Case']
    brands = ['Logitech','DJI','Otterbox']
    types = ['electronic','drone','case']
    ven_id = [2,3,4]
    for i in range(3):
        print('('+"\'"+names[i]+"\',"+"\'"+brands[i]+"\'"+','+"\'"+types[i]+"\'"+','+str(ven_id[i])+'),')
    name1 = ['Cool','Power','Flexible']
    name2 = ['Case','Skin','Charger']
    ran_name1 = ['Best','Quality','Tough']
    ran_name2 = ['Goods','Tech','Stuff']
    ven_id = 5
    for i in range(3):
        for j in range(3):
            name = name1[i]+' '+name2[j]
            brand = ran_name1[i]+' '+ran_name2[j]
            print('('+"\'"+name+"\',"+"\'"+brand+"\'"+','+"\'"+'accessory'+"\'"+','+str(ven_id)+'),')
            ven_id += 1
            
    

def configurables():
    conf_id = 1
    configurs = [] # will help us create models for products
    for i in range(1,5):
        print('('+"\'Ram\',"+str(i)+'),') # 3
        configurs.append((i,conf_id,'Ram'))
        conf_id += 1
        print('('+"\'Storage\',"+str(i)+'),') # 3
        configurs.append((i,conf_id,'Storage'))
        conf_id += 1
        print('('+"\'Color\',"+str(i)+'),') # 5
        configurs.append((i,conf_id,'Color'))
        conf_id += 1
    for i in range(5,7):
        print('('+"\'Color\',"+str(i)+'),') # 5
        configurs.append((i,conf_id,'Color'))
        conf_id += 1
        print('('+"\'Storage\',"+str(i)+'),') # 3
        configurs.append((i,conf_id,'Storage'))
        conf_id += 1
    print('('+"\'Color\',"+str(7)+'),') #5
    configurs.append((7,conf_id,'Color'))
    conf_id += 1
    return configurs

def model():
    model_list = []
    model_id = 1
    # how many models we need to specify for each product
    models = 5*3*3
    for i in range(1,5):
        for j in range(models):
            print('('+str(i)+'),')
            model_list.append((i,model_id))
            model_id += 1
    models = 3*5
    for i in range(5,7):
        for j in range(models):
            print('('+str(i)+'),')
            model_list.append((i,model_id))
            model_id += 1
    for j in range(7):
        print('('+str(7)+'),')
        model_list.append((7,model_id))
        model_id += 1
    for i in range(8,21):
        print('('+str(i)+'),')
        model_list.append((i,model_id))
        model_id += 1
    return model_list
        
# randomly generate configurations
def model_cofigurations(models,configs):
    rams = ['4GB','8GB','16GB']
    storage = ['256GB','512GB','1TB']
    colors = ['White','Black','Red','Blue','Green']
    for m in models:
        for c in configs:
            if m[0]==c[0]:
                if c[2]=='Ram':
                    print('('+str(c[1])+','+str(m[1])+','+"\'"+random.choice(rams)+"\'),")
                if c[2]=='Storage':
                    print('('+str(c[1])+','+str(m[1])+','+"\'"+random.choice(storage)+"\'),")
                if c[2]=='Color':
                    print('('+str(c[1])+','+str(m[1])+','+"\'"+random.choice(colors)+"\'),")

def stock(models):
    for store in range(1,21):
        for m in models:
            # not all stores have every item in stock
            if random.randint(0,100) > 75:
                print('('+str(store)+','+str(m[1])+','+str(random.randint(0,15))+','+str(round(random.uniform(10,1000),2))+'),')

def checkout():
    checkouts = []
    for i in range(50):
        pay_meth = random.choice(['Card','Cash','Bitcoin','Account'])
        store_id = random.randint(1,20)
        if random.randint(0,100)>50:
            apple_id = random.randint(3,23)
            print('('+random_date()+",\'"+pay_meth+"\',"+str(store_id)+','+str(apple_id)+'),')
        else:
            print('('+random_date()+",\'"+pay_meth+"\',"+str(store_id)+','+'NULL'+'),')

def product_purchases(models):
    for i in range(1,51):
        num_products = random.randint(1,5)
        for j in range(num_products):
            mod = random.choice(models)[1]
            print('('+str(mod)+','+str(i)+','+str(round(random.uniform(10,1000),2))+'),')

def device(models):
    for m in models:
        devices = random.randint(1,10)
        for i in range(devices):
            if m[1] <= 8:
                print('('+str(m[1])+','+str(random.randint(3,18))+'),')
        

### Main ###################################################################################


def main():
    apple_account()
    store()
    artists = artist()
    songs = song(artists)
    song_purchases(songs)
    developer()
    app()
    ap = app_purchase()
    consumables = in_app_items()
    ia_purch = in_app_purchases(ap,consumables)
    consumable_ownership(ia_purch)
    vendor()
    product1()
    c = configurables()
    m = model()
    model_cofigurations(m,c)
    stock(m)
    checkout()
    product_purchases(m)
    device(m)
    
    
    
if __name__=='__main__':
    main()

    
                            
            

    
