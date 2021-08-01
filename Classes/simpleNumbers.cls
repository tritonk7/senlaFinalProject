public class simpleNumbers {
    public static void getSimpleNumbers(integer x){
        integer i = 0, j = 0;
    for (i=2;i<x;i++){
            integer k=0;
    	for (j=2;j<=i;j++){
    			if (math.mod(i,j) == 0)
                k++;
    		}
            if (k<2)
    		system.debug(i);
    	}
        
    }
}