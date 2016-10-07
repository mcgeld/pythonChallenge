use strict;
use warnings;
$| = 1;

#  ADDING A PROBLEM:  ########################################
#                                                            #
# 1. Update the $TOTAL variable                              #
# 2. Add a summary to the summaries dictionary               #
# 3. Add a case in the switch subroutine                     #
# 4. Add the appropriate subroutine                          #
#                                                            #
##############################################################

# USING A LOADER: ##############################################
#                                                              #
# 1. Create a local scalar variable                            #
# 2. Initialize the variable to ""                             #
# 3. Every repetition of your loop, call loader($yourVariable) #
#                                                              #
################################################################

my $TOTAL = 11;
my %summaries = (
    0 => "2 ^ 38",
    1 => "Alphabet Shift",
    2 => "Rare Characters",
    3 => "Bodyguards",
    4 => "Linked List",
    5 => "In A Pickle",
    6 => "Zipper",
    7 => "Colorful Characters",
    8 => "Authentication",
    9 => "Connect The Dots",
    10 => "Look-And-Say",
    11 => "Evil Hidden Within"
);

for(my $i = 0; $i < scalar(@ARGV); $i++)
{
    my $val = $ARGV[$i];
    my $min = $val;
    my $max = $val;

    if($val =~ m/([0-9]+)-([0-9]+)/)
    {
        $min = $1;
        $max = $2;
    }
    elsif($val =~ m/([0-9]+)\+/)
    {
        $min = $1;
        $max = $TOTAL;
    }
    elsif($val =~ m/([0-9]+)-/)
    {
        $min = $1;
        $max = 0;
    }
    elsif($val eq "all")
    {
        $min = 0;
        $max = $TOTAL;
    }
    else
    {
        die "Invalid input please try again\n";
    }

    if($min <= $max)
    {
        for($val = $min; $val <= $max; $val++)
        {
            printHeader($val);
            switch($val);
            printFooter($val);
        }
    }
    else
    {
        for($val = $min; $val >= $max; $val--)
        {
            printHeader($val);
            switch($val);
            printFooter($val);
        }
    }
}

sub switch {
    my $val = shift;

    if ($val == 0) {zero();}
    elsif ($val == 1) {one();}
    elsif ($val == 2) {two();}
    elsif ($val == 3) {three();}
    elsif ($val == 4) {four();}
    elsif ($val == 5) {five();}
    elsif ($val == 6) {six();}
    elsif ($val == 7) {seven();}
    elsif ($val == 8) {eight();}
    elsif ($val == 9) {nine();}
    elsif ($val == 10) {ten();}
    elsif ($val == 11) {eleven();}
    else {print "Unregistered function: $val\n";}
}

sub zero {
    print 2**38;
}

sub one {
    `curl -O -s http://www.pythonchallenge.com/pc/def/map.html`;
    my $found = 0;
    my $string = "";
    open(IN, "<map.html") or die $!;
    while(($found < 2) && (my $line = <IN>))
    {
        if($found == 0)
        {
            if($line =~ m/<font color="#f000f0">/)
            {
                $found++;
            }
        }
        else
        {
            chomp($line);
            $string = $line;
            $found++;
        }
    }
    close IN;
    oneFunction($string);

    print "\n\nApplied to url: \n";

    $string = "map";
    oneFunction($string);

    `rm map.html`;
}

sub oneFunction {
    my $string = shift;
    my @words = split(" ", $string);

    my $output = "";

    foreach my $word (@words)
    {
        my @letters = split("", $word);
        my $outWord = "";
        foreach my $letter (@letters)
        {
            my $letterNum = ord($letter);
            if($letterNum >= ord("a") && $letterNum <= ord("z"))
            {
                $outWord .= chr(($letterNum + 2) > ord("z") ? ord("a") + (($letterNum + 1) % ord("z")) : $letterNum + 2);
            }
            else
            {
                $outWord .= $letter;
            }
        }
        $output .= $outWord . " ";
    }

    print($output);
}

sub two {
    `curl -O -s http://www.pythonchallenge.com/pc/def/ocr.html`;
    open(IN, "<ocr.html");
    open(OUT, ">2.txt");
    my $state = 0;
    my $commentIndex = 0;
    my $whichComment = 1; #0-based
    while(($state < 2) && (my $line = <IN>))
    {
        if($state == 0)
        {
            if($line =~ m/<!--/)
            {
                if($commentIndex < 1)
                {
                    $commentIndex++;
                }
                else
                {
                    $state++;
                    print OUT $line;
                }
            }
        }
        elsif($state == 1)
        {
            print OUT $line;
            if($line =~ m/-->/)
            {
                $state++;
            }
        }
    }
    close IN;
    close OUT;
    `rm ocr.html`;

    open(my $file, "<2.txt") or die $!;

    while(my $row = <$file>)
    {
        chomp($row);
        my @letters = split("", $row);
        foreach my $letter(@letters)
        {
            if(ord($letter) >= ord("a") && ord($letter) <= ord("z"))
            {
                print($letter);
            }
        }
    }

    close $file;
    `rm 2.txt`;
}

sub three {
    `curl -O -s http://www.pythonchallenge.com/pc/def/equality.html`;
    open(IN, "<equality.html");
    open(OUT, ">3.txt");
    my $state = 0;
    my $commentIndex = 0;
    my $whichComment = 0; #0-based
    while(($state < 2) && (my $line = <IN>))
    {
        if($state == 0)
        {
            if($line =~ m/<!--/)
            {
                if($commentIndex < $whichComment)
                {
                    $commentIndex++;
                }
                else
                {
                    $state++;
                    print OUT $line;
                }
            }
        }
        elsif($state == 1)
        {
            print OUT $line;
            if($line =~ m/-->/)
            {
                $state++;
            }
        }
    }
    close IN;
    close OUT;
    `rm equality.html`;

    open(my $file, "<3.txt") or die $!;

    while(my $line = <$file>)
    {
        chomp($line);

        for(my $i = 0; $i + 9 <= length($line); $i++)
        {
            my $sequence = substr($line, $i, 9);
            if(Surrounded($sequence) == 1)
            {
                print(substr($sequence, 4, 1));
            }
        }
    }

    close $file;
    `rm 3.txt`;
}

sub Surrounded {
    my $sequence = shift(@_);
    my $state = 0;
    my $valid = 1;
    for(my $j = 0; $j < 9 && $valid == 1; $j++)
    {
        my $char = substr($sequence, $j, 1);
        if($state != 0  && $state != 4 && $state != 8 && Lopper($char) == 1)
        {
            $state++;
        }
        elsif(($state == 0 || $state == 4 || $state == 8) && Lopper($char) == -1)
        {
            $state++;
        }
        else
        {
            $valid = 0;
        }
    }
    if($valid == 1)
    {
        return 1;
    }
    else
    {
        return 0;
    }

}

sub Lopper {
    my $letter = shift(@_);
    if(ord($letter) >= ord("A") && ord($letter) <= ord("Z"))
    {
        return 1;
    }
    elsif(ord($letter) >= ord("a") && ord($letter) <= ord("z"))
    {
        return -1;
    }
    else
    {
        return 0;
    }
}

sub four {
    my $next = "8022";
    my $baseUrl = "www.pythonchallenge.com/pc/def/linkedlist.php?nothing=";
    my $message = "";
    my $done = 0;
    my $loadingString = "";

    while($done == 0)
    {
        my $nextUrl = $baseUrl.$next;
        `curl -s $nextUrl > out.txt`;
        open(IN, "<out.txt") or die $!;
        my $found = 0;
        while(($done == 0) && (my $line = <IN>))
        {
            if($line =~ m/and the next nothing is ([0-9]*)/)
            {
                $next = $1;
                $found = 1;

                print(" " x length($loadingString));
                print("\b" x length($loadingString));

                if(length($loadingString) < 5)
                {
                    $loadingString .= ".";
                }
                else
                {
                    $loadingString = "";
                }
                print $loadingString;
                print("\b" x length($loadingString));
            }
        }
        if($found != 1)
        {
            $done = 1;
            $message = "The final number was $next";
        }
    }

    `rm out.txt`;
    print $message;
}

sub five {
    `curl -O -s http://www.pythonchallenge.com/pc/def/banner.p`;

    open(PY, ">banner.py");

    print PY "import pickle\n";
    print PY "f = open('banner.p', 'rb')\n";
    print PY "mydict = pickle.load(f)\n";
    print PY "f.close()\n\n";
    print PY "print (mydict)";

    close PY;

    `python banner.py > 5.txt`;

    open(IN, "<5.txt");

    my $line = <IN>;
    chomp($line);

    my @bannerLines = split('\[', $line);

    foreach my $bannerLine (@bannerLines)
    {
        chop($bannerLine);
        chop($bannerLine);
        my @parts = split('\(', $bannerLine);
        foreach my $part (@parts)
        {
            my @elements = split(',', $part);

            if(scalar(@elements) > 0)
            {
                my $char = "";
                my $reps = "";

                if($elements[0] =~ m/\'(.)\'/)
                {
                    $char = $1;
                }

                if($elements[1] =~ m/([0-9]+)/)
                {
                    $reps = $1;
                }

                for(my $i = 0; $i < $reps; $i++)
                {
                    print $char;
                }
            }
        }
        print "\n";
    }

    close IN;

    `rm banner.p`;
    `rm banner.py`;
    `rm 5.txt`;
}

sub six {
    `curl -O -s http://www.pythonchallenge.com/pc/def/channel.zip`;
    `mkdir channel`;
    `unzip -q channel.zip -d channel`;

    my $next = "90052";
    my $comments = "";
    my @array = ();
    my $done = 0;
    my $message = "";
    my $loadingString = "";

    while($done == 0)
    {
        loader($loadingString);
        my $nextFile = $next . ".txt";
        open(IN, "<channel/$nextFile") or die $!;
        my $found = 0;
        while(my $line = <IN>)
        {
            chomp($line);
            if($line =~ m/Next nothing is ([0-9]*)/)
            {
                $next = $1;
                $found = 1;

            }
        }
        close(IN);

        open(PY, ">channel.py");

        print PY "import zipfile\n";
        print PY "import sys\n";
        print PY "myZip = zipfile.ZipFile('channel.zip', 'r')\n";
        print PY "myInfo = myZip.getinfo(sys.argv[1])\n";
        print PY "print(myInfo.comment)\n";

        close PY;

        my $comment = `python channel.py $nextFile`;
        if($comment =~ m/b'(.+)'/)
        {
            if($1 eq "\\n")
            {
                push(@array, $comments);
                $comments = "";
            }
            else
            {
                $comments .= $1;
            }
        }

        if($found != 1)
        {
            print "$_\n" foreach @array;
            $message = "The final number was $next";
            $done = 1;
        }
    }
    print $message;

    `rm channel/*.*`;
    `rmdir channel`;
    `rm channel.zip`;
    `rm channel.py`;
}

sub seven {
    `curl -O -s http://www.pythonchallenge.com/pc/def/oxygen.png`; 

    open(PY, ">oxygen.py");

    print PY "from PIL import Image\n";
    print PY "import sys \n\n";
    print PY "im = Image.open('oxygen.png') \n"; 
    print PY "px = im.load() \n\n";
    print PY "prev = 0 \n"; 
    print PY "for x in range(0, im.size[0]): \n"; 
    print PY "  curr = px[x, 45] \n";
    print PY "  if curr[0] == curr[1] and curr[1] == curr[2]: \n"; 
    print PY "      if curr[0] != prev: \n"; 
    print PY "          prev = curr[0] \n";
    print PY "          sys.stdout.write(chr(curr[0])) \n";

    close PY;

    my $output = `python oxygen.py`;
    print $output;

    my $nextSet = "";
    if($output =~ m/\[(.*)\]/)
    {
        $nextSet = $1;
    }

    print "\n\nThose numbers converted are: ";

    my @nums = split(',', $nextSet);
    foreach my $num (@nums)
    {
        if($num =~ m/([0-9]+)/)
        {
            if($num < 100)
            {
                $num += 100;
            }
            print chr($num);
        }
    }

    `rm oxygen.png`;
    `rm oxygen.py`;
}

sub eight {
    `curl -O -s http://www.pythonchallenge.com/pc/def/integrity.html`;
    my @creds = ();
    my @results = ();
    open(IN, "<integrity.html");
    while(my $line = <IN>)
    {
        if($line =~ m/un: '(.*)'/)
        {
            push(@creds, $1);
        }
        elsif($line =~ m/pw: '(.*)'/)
        {
            push(@creds, $1);
        }
    }

    if(scalar(@creds) < 2)
    {
        print "THERE WAS AN ERROR... SORRY!\n";
        return;
    }

    foreach my $cred (@creds)
    {

        open(PY, ">integrity.py");

        print PY "import bz2\n";
        print PY "import sys\n";
        print PY "mystring = b'$cred'\n";
        print PY "print (bz2.decompress(mystring))";

        close PY;

        my $result = `python integrity.py`;
        if($result =~ m/b'(.*)'/)
        {
            push(@results, $1);
        }
    }

    print "username: $results[0]\npassword: $results[1]";

    `rm integrity.html`;
    `rm integrity.py`;
}

sub nine {
    `curl -O -s --user huge:file http://www.pythonchallenge.com/pc/return/good.html`;

    open(IN, "<good.html") or die $!;

    my @coords = ();
    my $state = 0;

    while(($state < 4) && (my $line = <IN>))
    {
        if($state == 0)
        {
            if($line =~ m/first:/)
            {
                $state++;
            }
        }
        elsif($state == 1)
        {
            chomp($line);
            my @arr = split(',', $line);
            if(scalar(@arr) > 0)
            {
                push(@coords, $_) foreach @arr;
            }
            else
            {
                $state++;
            }
        }
        elsif($state == 2)
        {
            if($line =~ m/second:/)
            {
                $state++;
                push(@coords, 0);
                push(@coords, 0);
            }
        }
        elsif($state == 3)
        {
            chomp($line);
            my @arr = split(',', $line);
            if(scalar(@arr) > 0)
            {
                push(@coords, $_) foreach @arr;
            }
            else
            {
                $state++;
            }
        }
    }

    close IN;

    `curl -O -s --user huge:file http://www.pythonchallenge.com/pc/return/good.jpg`;

    #file to create blank image
    open(OUT, ">createImage.py");

    print OUT "from PIL import Image\n"; 
    print OUT "base = Image.open('good.jpg')\n";
    print OUT "new = Image.new('RGBA', base.size, (0, 0, 0, 0))\n";
    print OUT "new.save('output.jpg')";

    close OUT;


    #file to draw lines
    open(OUT, ">nine.py");

    print OUT "from PIL import Image, ImageDraw\n";
    print OUT "import sys \n";
    print OUT "im = Image.open('output.jpg')\n";
    print OUT "draw = ImageDraw.Draw(im)\n";
    print OUT "draw.line((int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4])), fill=255)\n";
    print OUT "del draw\n\n";
    print OUT "im.save('output.jpg')";

    close OUT;


    #file to display image
    open(OUT, ">show.py");

    print OUT "from PIL import Image\n";
    print OUT "im = Image.open('output.jpg')\n";
    print OUT "im.show()";

    close OUT;

    `python createImage.py`;

    my $prevx = $coords[0];
    my $prevy = $coords[1];
    my $loadingString = "";

    for(my $i = 2; $i < scalar(@coords);)
    {
        loader($loadingString);
        my $x = $coords[$i++];
        my $y = $coords[$i++];

        if(!($x == 0 && $y == 0))
        {
            `python nine.py $prevx $prevy $x $y`;
            $prevx = $x;
            $prevy = $y;
        }
        else
        {
            $prevx = $coords[$i++];
            $prevy = $coords[$i++];
        }
    }

    `python show.py`;

    print "Hmmm... Using image recognition software, I'd say that looks like a BULL!";

    `rm good.html`;
    `rm createImage.py`;
    `rm nine.py`;
    `rm show.py`;
    `rm output.jpg`;
    `rm good.jpg`;
}

sub ten {
    my $prev = "1";
    my $output = "";
    for(my $i = 0; $i < 30; $i++)
    {
        my $count = 0;
        my @digits = split('', $prev);
        my $state = 0;
        my $number = "";
        $output = "";
        foreach my $digit (@digits)
        {
            if($state == 0)
            {
                $number = $digit;
                $count++;
                $state++;
            }
            elsif($state == 1)
            {
                if($digit == $number)
                {
                    $count++;
                }
                else
                {
                    $output .= "$count$number";
                    $number = $digit;
                    $count = 1;
                    $state = 1;
                }
            }
        }
        $output .= "$count$number";
        $prev = $output;
    }
    print length($output);
}

sub eleven {
    `curl -O -s --user huge:file http://www.pythonchallenge.com/pc/return/cave.jpg`;
    open(OUT, ">eleven.py");

    print OUT "from PIL import Image, ImageDraw\n\n";
    print OUT "im = Image.open('cave.jpg')\n";
    print OUT "new1 = Image.new('RGBA', im.size, (0, 0, 0, 0))\n\n";
    print OUT "draw1 = ImageDraw.Draw(new1)\n\n";
    print OUT "px = im.load()\n\n";
    print OUT "for y in range(0, im.size[1]):\n";
    print OUT "    for x in range(0, im.size[0]):\n";
    print OUT "        curr = px[x, y]\n";
    print OUT "        if (x + y) % 2 == 0:\n";
    print OUT "            draw1.point((x, y), fill=(curr[0], curr[1], curr[2]))\n";
    print OUT "new1.show()";

    close OUT;

    `python eleven.py`;

    print "Using advanced text recognition algorithms, that looks like EVIL!";

    `rm cave.jpg`;
    `rm eleven.py`;
}

sub printHeader {
    my $number = shift;
    my $topLine = ("==================== CHALLENGE $number ====================");
    my $summary = $summaries{$number};
    my $diff = length($topLine) - (length($summary) + 2);
    my $left = int($diff / 2);
    my $right = $diff % 2 == 0 ? $left : $left + 1;
    print $topLine, "\n";
    print "=" foreach(1..$left);
    print " $summary ";
    print "=" foreach(1..$right);
    print "\n\n";
}

sub printFooter {
    my $number = shift;
    print("\n\n===============================");
    print "=" foreach (0..length($number));
    print("====================\n\n\n\n");
}

sub loader {

    print(" " x length($_[0]));
    print("\b" x length($_[0]));

    if(length($_[0]) < 5)
    {
        $_[0] .= ".";
    }
    else
    {
        $_[0] = "";
    }
    print $_[0];
    print("\b" x length($_[0]));
}
