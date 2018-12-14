require 'cucumber/formatter/html'

module Formatter 
  class HtmlFormatter < Cucumber::Formatter::Html
    def embed(src, mime_type, label)
      case(mime_type)
        when /^image\/(png|gif|jpg|jpeg)/
          super(src, mime_type, label)  
        when /^text\/html/
          embed_link(src, label)
        when /^step\/html/
          embed_step(src, label)
      end
    end
  
    def embed_link(src, label)
      @builder.span(:class => 'embed') do |pre| 
        pre << %{<a href="#{src}" target="_blank">"#{label}"</a> } 
      end
    end
    def embed_step(link,code)
      if code.match(/^40/) || code.match(/^50/) #code == "404" || code == "5*"
        @builder.li(:class => 'step failed') do |pre|
          pre << %{<div class="step_name">
            <span class="keyword">Link : "#{link}" </span><span class="step val"> Status Code was "#{code}"
              </span> </div><div class="step_file"><span>features/step_definitions/gmail_steps.rb:1</span></div>}

        end
      else
        @builder.li(:class => 'step passed') do |pre|
          pre << %{<div class="step_name">
          <span class="keyword">Link : "#{link}" </span><span class="step val"> Status Code was "#{code}"
            </span> </div><div class="step_file"><span>features/step_definitions/gmail_steps.rb:1</span></div>}

        end
      end



#       <li id="" class="step passed">
#       <div class="step_name"><span class="keyword">
#           Given </span><span class="step val">User page is opened</span>
#       </div>
# </li>
    end
  end
end
