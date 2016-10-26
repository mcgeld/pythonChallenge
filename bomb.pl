                    @a=([
                    33,1]
                     ,[17,
                      4] ,[
                       9,16]
                       ,[ 5,
                      64],[
                     963 ,
                    256],
                   [127,
                   1016]
                   ,[ 5,
                    527],
                    [ 17,
                     256],
                      [ 65,
                       128],
                       [257,
                       64 ],
                       [1,32
                       ] ) ;
                    @b=( 18,93,
                    91,58,107);
                  $|++; for($c=4;
              $c>=0 ; $c--) {spr($c);
          sleep(1);}exd();sub exd{system(
       "clear");for($d=0; $d<50; $d++){for$e
     (0..$#a){for$f(0..1) {$g=dec($a[$e][$f]);
   $g=~s/0/ /g;$g=~s/1/#/g;print$g;} print"\n";}
  sleep(0.025); system("clear"); } } sub dec{ $g=
 sprintf("%010b",shift); return$g;}sub spr{system(
"clear"); $h=shift; $i=sprintf("%07b", $b[$h]) ;@j=
split('',$i);$h++;for($k=0; $k<13; $k++){if($k==0){
print" ";print$j[0]eq"1"?$h:" "foreach(1..10);print
" ";} elsif($k<6){print$j[1] eq"1"?$h:" "; print" "
foreach(1..10);print$j[2]eq"1"?$h:" ";}elsif($k==6)
 {print" "; print$j[3]eq"1"? $h:" "foreach(1..10);
  print" ";}elsif($k<12) {print$j[4]eq"1"?$h:" ";
   print" "foreach(1..10);print$j[5]eq"1"?$h:" "
     ;} else {print" "; print$j[6]eq"1"?$h:" "
       foreach(1..10);print" ";}print"\n";}}
          @l= (77,97,108,99,111,108,109);
              print"Author: ";print chr
                  ($_)foreach@l; 
                     <STDIN>; 
