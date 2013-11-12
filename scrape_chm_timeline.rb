require 'nokogiri'
require 'open-uri'
#            <div id="tdihbody">
#                <!-- Computing History Content starts here -->
#                <div class="tdihevent">
#                    <div class="tdihimage">
#                        <div class="image layout"><img class="main" src="/tdih/img/01January_1_a.jpg" title="Heinz Zemanek" /></div><!-- image here -->
#                        <div class="caption">Heinz Zemanek</div><!-- image captions here -->
#                    </div>
#                    
#                    <h3 class="title">January 1, 1920</h3>
#                    <p class="subtitle">Mailüfterl's Developer Heinz Zemanek is Born</p>
#                    <p>Heinz Zemanek, one of the European pioneers in computer technology, is born in Vienna, Austria. He studied at the University of Technology Vienna and received a doctorate degree in 1951. During 1954 - 1959 Zemanek gathered a group of students to develop the Mailuefterl, one of the earliest fully transistorized computers in Europe. From 1961 to 1975 Zemanek was Director of the IBM Laboratory Vienna which was established for his team. During this period Zemanek designed the PL/I programming language. The formal definition was written in the Vienna Definition Language, which was later extended to the Vienna Definition Method. (VDL and VDM). From 1968 to 1971 he founded the Austrian Computer Society and was President of the International Federation for Information Processing (IFIP). In 1976 Professor Zemanek was appointed IBM Fellow. </p>
#                    
#                <br style="clear: both;" />    
#                </div><div class="tdihevent">
#                    <div class="tdihimage">
#                        <div class="image layout"><a href="/tdih/img/01January_1_b.jpg" title="The EDVAC"><img class="magnify" src="/tdih/img/bckgrnd/magnify.jpg" /></a><a href="/tdih/img/01January_1_b.jpg" title="The EDVAC"><img class="main" src="/tdih/img/01January_1_b.jpg" title="The EDVAC" /></a></div><!-- image here -->
#                        <div class="caption">The EDVAC</div><!-- image captions here -->
#                    </div>
#                    
#                    <h3 class="title">January 1, 1945</h3>
#                    <p class="subtitle">Eckert and Mauchly sign a contract to build the EDVAC</p>
#                    <p>Eckert and Mauchly sign a contract to build the EDVAC (Electronic Discrete Variable Computer), the first general-purpose electronic digital-stored program computer to be designed. Even before the ENIAC had been unveiled in 1946, Eckert and Mauchly were already thinking about their next machine. In June 1945 John von Neumann, who took an active part in the design discussions, made a key contribution to the understanding and development of computer architecture in his unpublished report titled First Draft of a Report on the EDVAC. <p>The EDVAC was completed only in 1952, long after Eckert and Mauchly had left the University of Pennsylvania. The machine which was heavily modified from its original design had been used for ballistic and satellite calculations. The EDVAC was shut off in January 1963.</p>
#                    
#                <br style="clear: both;" />    
#                </div>
#               <!-- Computing History Content ends here -->

def get_tdih(month,day_number)
    # Looking for div class="tdihevent", p class="subtitle"
    doc = Nokogiri::HTML(open("http://www.computerhistory.org/tdih/#{month}/#{day_number.to_s}/"))
    dates = doc.xpath("//div[contains(@class,'tdihevent')]/h3[contains(@class,'title')]").collect {|node| node.text.strip}
    items = doc.xpath("//div[contains(@class,'tdihevent')]/p[contains(@class,'subtitle')]").collect {|node| node.text.strip}
    #puts "#{month} #{day_number.to_s}:" 
    entries = dates.zip(items)
    entries.collect {|d,i| "#{d}  #{i}"}
end

DAYS_TO_CHECK = {January:1..31,February:1..28,March:1..31,April:1..30,May:1..31,June:1..30,July:1..31,August:1..31,September:1..30,October:1..31,November:1..30,December:1..31}
DAYS_TO_CHECK.each do |month,day_range|
    day_range.each  {|day_number| puts get_tdih month,day_number   }
end
