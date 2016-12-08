require 'rest-client'
require 'nokogiri'

# filmography DOM/css selector is: "#maindetails_center_bottom > div:nth-child(3) > h2"
class BaconCrawler
def initialize(person)
    # line below is saying make an instance variable equal to the argument value. now booyah has access to that "initialize" method
    @person = person
    # hard coded to be kevin bacon's imdb page
    @root = "http://www.imdb.com/name/nm0000102/?ref_=fn_al_nm_1"
end
# def test
#     # do this before typing any more methods below! it's just making sure we're wired up correctly. also test wiring by misspelling one of the require dependencies, example 'nokogirsi'
#     puts 'booyah!!!'
# end

    def findMovies
        # doc is equal to what the visit(url) method is returning
        doc = visit(@root)
        # puts inspect line below lets us inspect the object returned with the CLI by typing irb. irb is ruby's REPL and will run whatever you write in the CLI.
        # puts doc.inspect
        puts doc.css("#filmography > div:nth-child(2)")

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
