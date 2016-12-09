require_relative './queue'
require 'rest-client'
require 'nokogiri'

# filmography DOM/css selector is: "#maindetails_center_bottom > div:nth-child(3) > h2"
class BaconCrawler
def initialize(person)
    # line below is saying make an instance variable equal to the argument value. now booyah has access to that "initialize" method
    @person = person
    # hard coded to be kevin bacon's imdb page
    @root = "http://www.imdb.com/name/nm0000102/?ref_=fn_al_nm_1"
    @queue = Queue.new
    #the line below is running the findMovies function to populate a queue list before we do the bacon_first_search
    findMovies
end
# def test
#     # do this before typing any more methods below! it's just making sure we're wired up correctly. also test wiring by misspelling one of the require dependencies, example 'nokogirsi'
#     puts 'booyah!!!'
# end

    def bacon_first_search
        nextNode = @queue.dequeue
        # puts nextNode
        #run the visit method on the object's url property
        puts visit(nextNode[:url])
        #REST OF LOGIC FOR THE EXERCISE:
        # if @found
        #     return
        # else
        #     call bacon_first_search on the next
        # end
    end


    def findMovies
        # doc is equal to what the visit(url) method is returning
        doc = visit(@root)
        # puts inspect line below lets us inspect the object returned with the CLI by typing irb. irb is ruby's REPL and will run whatever you write in the CLI.
        # puts doc.inspect
        # line below grabs the a tag within the b tag within the filmography table on the website
        movies_list = doc.css("#filmography > div:nth-child(2) b > a")
        #line below returns list of movie names as a paragraph.
        # puts movies_list.inner_html


        movies_list.each do |movie|
            #saving the puts just for reference
            # puts movie.inner_html
            # puts movie.attribute('href')
            #create our queue objects and call the queue's enqueue method
            @queue.enqueue({
                name: movie.inner_html,
                url: "http://www.imdb.com#{movie.attribute('href')}",
                type: 'movie',
                parent: 'KEVIN BACON!'
                })
        end
        #print all our movie objects is line below
        # puts @queue.all
    end

    def visit(url)
        begin
         response = RestClient.get url
        rescue RestClient::ExceptionWithResponse => e
        e.response
        end
        # puts response
        doc = Nokogiri::HTML(response)
    end
end
