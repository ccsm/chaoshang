class Node
  include Mongoid::Document
   field :name, type: String
 
       set_callback(:create,:before) do |document|
        p "()()()()"
       p document.id
       end

  
   
end
