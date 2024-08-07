function index = findCellStringIndex(cell, string )
%{
 Given a cell of string, find all index of elements containing 'string'.
%}   


tmp_index=[];
for k=1:length(cell)
    
    if strcmp(cell{k},string)
        
        tmp_index(k)=1;
    else
        
        tmp_index(k)=0;
    end 
    
    
end 

index=logical(tmp_index);
end

