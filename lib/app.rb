require 'json'
require 'date'

#init
#---------------------------------------------------
def setup_files
    path = File.join(File.dirname(__FILE__), '../data/products.json')
    file = File.read(path)
    $products_hash = JSON.parse(file)
    $report_file = File.new("report.txt", "w+")
end

def create_report
  $report_file.puts "report head"
  $report_file.puts "report content"
  $report_file.puts "report foot"
end

def start
  setup_files # load, read, parse, and create the files
  create_report # create the report!
end


#---------------------------------------------------
def print_date
  puts "Date: #{Time.now.strftime("%m-%d-%Y")}"
end
#---------------------------------------------------

#print ascii
#---------------------------------------------------
def print_ascii_products
  puts "                     _            _       "
  puts "                    | |          | |      "
  puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
  puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
  puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
  puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
  puts "| |                                       "
  puts "|_|                                       "
end

def print_ascii_brand
	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts
end

#I am not an artist
def print_ascii_sale_report
  puts "--------       -            -             --------      --------  "
  puts "-             -  -          -             -             -         "
  puts "-            -    -         -             -             -         "
  puts "--------    --------        -             ---------     --------- "
  puts "       -   -         -      -                      -            - "
  puts "       -  -            -    -                      -            - "
  puts "--------                    ----------    ----------    --------- "
end
#---------------------------------------------------

start()

# Print "Sales Report" in ascii art
print_ascii_sale_report

# Print today's date
print_date

# Print "Products" in ascii art
print_ascii_products

# For each product in the data set:
	# Print the name of the toy
	# Print the retail price of the toy
	# Calculate and print the total number of purchases
	# Calculate and print the total amount of sales
	# Calculate and print the average price the toy sold for
	# Calculate and print the average discount (% or $) based off the average sales price
  def print_name_and_value( the_name, the_value )
    puts the_name + the_value
  end
  
  def print_bar
    puts "----------"
  end
  
  def get_sum_price( collection )
    collection.inject(0) { |total, each_one| total + each_one["price"] }
  end
  
  def get_average( total, num )
    total / num
  end
  
  def get_discount( full_price, price )
    ( full_price - price ).round(3)
  end
  
  def get_product_num( items )
    num = items["purchases"].length
  end
  
  def get_product_average_price( items )
    num = get_product_num( items )
    total_amount = get_sum_price( items["purchases"] )
    average_price = get_average( total_amount, num )
  end
  #--------------------------------------------------------------  
  def print_product_report
    $products_hash["items"].each do |items|  
      print_name_and_value( "Name : ", items["title"] )
      print_name_and_value( "retail price : ", items["full-price"] )
    
      average_price = get_product_average_price(items)
  
      print_name_and_value( "Total number purchased : ", get_product_num(items).to_s )
      print_name_and_value( "Total amount sold : ", get_sum_price( items["purchases"] ).to_s )
      print_name_and_value( "Average price : ", average_price.to_s )
      print_name_and_value( "Discount : $", ( get_discount( items["full-price"].to_f, average_price ) ).to_s )
      
      print_bar
    end
  end
  
  print_product_report
  #--------------------------------------------------------------
  
# Print "Brands" in ascii art
print_ascii_brand

# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined
  #--------------------------------------------------------------
  def group_by_brand
    $products_hash["items"].map { |items| items["brand"] }.uniq
  end
  
  def get_brand( name )
    $products_hash["items"].select { |it| it["brand"] == name }
  end
  
  def get_total_stock( items )
    items.inject(0) { |total, it| total + it["stock"] } 
  end
  
  def get_sold_num( items )
    sold_num = 0
    items.each do |its|  
      sold_num += its["purchases"].inject(0) { |total_num, it| total_num + 1 }
    end
    return sold_num
  end
  
  def get_total_price( items )
    total_price = 0.0
    items.each do |its| 
      total_price += its["purchases"].inject(0) { |total_prc, it| total_prc + its["full-price"].to_f }
    end
    return total_price
  end
  
  def get_total_revenue( items )
    total_revenue = 0.0
    items.each do |its|  
      total_revenue += its["purchases"].inject(0) { |total_rvn, it| total_rvn + it["price"].to_f }
    end
    return total_revenue
  end
  
  def print_brand_report
    brand_name = group_by_brand
  
      brand_name.each do |name|
        puts "Brand : " + name
    
        by_brand = get_brand( name )
    
        stock = get_total_stock( by_brand )
        puts "Stock : " + stock.to_s
    
        sold_num = get_sold_num( by_brand )
        total_price = get_total_price( by_brand )
        total_revenue = get_total_revenue( by_brand )        
    
    
    print_name_and_value( "Avarage Price : ", (total_price/sold_num).round(2).to_s )
    print_name_and_value( "Total Revenue : " , total_revenue.round(2).to_s )
        
    print_bar
    end
    
  end
  #--------------------------------------------------------------
  
  print_brand_report


 