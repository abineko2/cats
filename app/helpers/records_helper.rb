module RecordsHelper
     def set_array
         array =[]
         @cats.each do |cat|
             array << cat.cat_name
         end     
         array << "すべての猫ちゃん"
         return array
     end   
#==１歳以下の猫配列
    def cat_ages
      @arr= [["1歳以下の子はこちらで詳細を選択ください",10],["生後0ヶ月",0],["生後1ヵ月",0.1],["生後2ヵ月",0.2],["生後3ヵ月",0.3],["生後6ヵ月",0.6],["生後9ヵ月",0.9],["生後12ヵ月",1.0]] 
    end
end