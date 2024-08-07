

#  This function is used to read mothly QA resutls txt files and used to updata QATrack+ if all files exist in current directory or specified diectory.

import os

# list the the monthly QA resutl files for each sequences under current dir or specifile the path+file name. 

qa_file_list=('monthlyTmpSE.txt','monthlyTmpGE.txt','monthlyTmpDIXON.txt','monthlyTmpUTE.txt')

def isFileList(qa_file_list):
    
    '''
    To judege if the all monthly QA result file list exists,namely, QA results for each 
    image sequences.
    
    @ qa_file_list: tuple containing QA file list (path+file name).
    
    @@ logical: True or False
    
    '''
    
    
    se_qa=qa_file_list[0]
    
    ge_qa=qa_file_list[1]
    
    dixon_qa=qa_file_list[2]
    
    ute_qa=qa_file_list[3]
    
    
    if os.path.isfile(se_qa) and os.path.isfile(ge_qa) and \
       os.path.isfile(dixon_qa) and os.path.isfile(ute_qa):
    
          
       return True 

    else:

        
       return False 

def removeFileList(qa_file_list):
    
    '''
    
    To remove all monthly QA files after update QA track.
    
    @ qa_file_list
    
    @@: 
    
    '''

    # first to see if the file list exists    
    
    file_exist=isFileList(qa_file_list)
    
    se_qa=qa_file_list[0]
    
    ge_qa=qa_file_list[1]
    
    dixon_qa=qa_file_list[2]
    
    ute_qa=qa_file_list[3]
    
    if file_exist:
        
        os.remove(se_qa)
        
        os.remove(ge_qa)
        
        os.remove(dixon_qa)
        
        os.remove(ute_qa)
        
        print 'The file list was removed.'
        
    else:
        
        print 'The file list does not exist.'

        
   
    
    
def collectMonthlyQAResults(qa_file_list):
    
    '''
    To read all monthly QA resutls into a tuple in righ oder as shown in QATrack+.
    
    @ qa_file_list: tuple containing QA file list (path+file name).
    
    @@ tuple: contaiing all monthly QA result for SE,GE,UTE and DIXON.
    
       first element-the date/time taken from SE sequence images.
    
       other elements-float values of results.
    
    
    '''
    
    # container for monthly QA results
    
    monthly_qa_result=[]
    
    #  judge if file exists
    
    is_file_exist=isFileList(qa_file_list)
    
    # process the resutls
    
    if is_file_exist:
        
        
        # read all files into a list
        
        se_qa_file=qa_file_list[0]
        
        ge_qa_file=qa_file_list[1]
        
        ute_qa_file=qa_file_list[2]
        
       
        dixon_qa_file=qa_file_list[3]
        
        # open the files
        
        se_file_obj=open(se_qa_file,'r')
        
        ge_file_obj=open(ge_qa_file,'r')
        
        ute_file_obj=open(ute_qa_file,'r')
        
        dixon_file_obj=open(dixon_qa_file,'r')
        
        # read the resutls into list
        
        se_result=se_file_obj.readlines()
        ge_result=ge_file_obj.readlines()
        ute_result=ute_file_obj.readlines()
        dixon_result=dixon_file_obj.readlines()
        
        se_last_line=se_result[-1]
        
        ge_last_line=ge_result[-1]
        
        ute_last_line=ge_result[-1]
              
        dixon_last_line=dixon_result[-1]
       
        
        # split the last results
        
        se_result=se_last_line.split(',')
        
        ge_result=ge_last_line.split(',')
        
        ute_result=ute_last_line.split(',')
        
        dixon_result=dixon_last_line.split(',')
        
         
        # get last resutls
        
        se_result_selected=se_result[0:len(se_result)-1]     # use SE date as primary key which is same as in qaTrack database.
        
      
        ge_result_selected=ge_result[1:len(ge_result)-1]     #  excluding the date and operator.
        
        ute_result_selected=ute_result[1:len(ute_result)-1]  # excluding the date and operator
        
        dixon_result_selected=dixon_result[1:len(dixon_result)-1] # excluding the date and operator
        
        
        
        # combine all results in string format.
        
        
        monthly_qa_result=se_result_selected+\
                          ge_result_selected+\
                          ute_result_selected+\
                          dixon_result_selected
                        
               
        # convert the string value to float
        
        monthly_qa_result_number= monthly_qa_result[1:len(monthly_qa_result)]
        
               
        monthly_qa_result_number=[float(x) for x in  monthly_qa_result_number]
        
        monthly_qa_result=[monthly_qa_result[0]]+monthly_qa_result_number
        
        
                        
        return tuple(monthly_qa_result)
    
    
    else:
        
        # in the case where there are no files.
        return False  
    
          
if __name__=='__main__':
    
    
    '''
    Main function.
        
    '''
    
    
    # test ifFileList
    
    qa_file_list=('monthlyTmpSE.txt','monthlyTmpGE.txt','monthlyTmpDIXON.txt','monthlyTmpUTE.txt')
    
    
    test_logic=isFileList(qa_file_list)
    
    print test_logic
        
    
    # test collectMontlyQAResults
    
    
    all_results=collectMonthlyQAResults(qa_file_list)
    
    print all_results
    
      
    
    # test removeFileList
    
##    removeFileList(qa_file_list)
        
        
        
        
        
        
        
    