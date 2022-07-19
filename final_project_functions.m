%flaten insert imaige
function flatPic = Flatten(picture)
%all red values above 155 set to 1 and others 0
flatPic = picture(:,:,1)>155;
end
%odd/even red
function output = OddEvenEmbedding(pictureMain,pictureinput,color)
%loop through imaige
for i=1:400
    for j=1:400
        %if value odd set to an even one
        if( rem(pictureMain(i,j,color),2) == 1)
            pictureMain(i,j,color) = pictureMain(i,j,color)-1;
        end
        %change to odd value where pictureinput is 1
        if( pictureinput(i,j) == 1)
            if( rem(pictureMain(i,j,color),2) == 0)
                pictureMain(i,j,color) = pictureMain(i,j,color) + 1;
            end
        end
    end
end
%set putput
output = pictureMain;
end
function output = OddEvenRecovery(pictureIn,color)
%create empty array
output = zeros(400);
for i=1:400
    for j=1:400
        %place 1 at index where input value odd
        if( rem(pictureIn(i,j,color),2) == 1)
            output(i,j) = 1;
        end
    end
end
end
%tenth place odd even Red
function output = TenthPlaceEmbedding(pictureMain,pictureInput,color)
%set hold to equal remainder of division by 100
hold = pictureMain(:,:,color);
hold = rem(hold,100);
for i=1:400
    for j=1:400
        %divide by a hundred to get tenths
        hold(i,j) = ( hold(i,j) - rem(pictureMain(i,j,color),10) )/10;
        %set values to even values
        if(rem(hold(i,j),2) == 1)
            pictureMain(i,j,color) = pictureMain(i,j,color) - 10;
            hold(i,j) = hold(i,j) - 1;
        end
        %if pictureinput is 1 set vlaue to odd
        if( pictureInput(i,j) == 1)
            if( rem(hold(i,j),2) == 0)
            pictureMain(i,j,color) = pictureMain(i,j,color) + 10;
            end
        end
    end
end
%set output
output = pictureMain;
end
function output = TenthPlaceRecovery(pictureInput,color)
%get remainder of division by 10
pictureInput = pictureInput(:,:,color);
pictureInput = rem(pictureInput,100);
%create empty array
output = zeros(400);
%create array of remainder values below 10
hold = rem(pictureInput,10);
for i=1:400
    for j=1:400
        %subtract remainders from main value and divide by 10
        pictureInput(i,j) = ( pictureInput(i,j) - hold(i,j) )/10;
        %if value is odd set index to 1 in output
        if( rem(pictureInput(i,j),2) == 1 )
            output(i,j) = 1;
        end
    end
end
end
%numerical check counting red
function output = ValueBasedEmbedding(pictureMain,pictureInput,color)
%set hold variable to ones place of layer color
hold=rem(pictureMain(:,:,color),10);
for i=1:400
    for j=1:400
        %filter values out associated with high output
        if( (hold(i,j) == 0)||(hold(i,j) == 1) )
            pictureMain(i,j,color) = pictureMain(i,j,color) + 2;
            hold(i,j) = hold(i,j) + 2;
        elseif( (hold(i,j) == 9)||(hold(i,j) == 8)||(hold(i,j) == 5)||(hold(i,j) == 4) )
            pictureMain(i,j,color) = pictureMain(i,j,color) - 2;
            hold(i,j) = hold(i,j) - 2;
        end
        %if pictureinput value at index high set value associated with high
        if(pictureInput(i,j) == 1)
            if( (hold(i,j)==2)||(hold(i,j)==3)||(hold(i,j)==6)||(hold(i,j)==7) )
                pictureMain(i,j,color) = pictureMain(i,j,color) + 2;
            end
        end
    end
end
%set output
output = pictureMain;
end
function output = ValueBasedRecovery(pictureInput,color)
%create empty array
hold = zeros(400);
%leave remainder of ones place
pictureInput = rem(pictureInput(:,:,color),10);
for i=1:400
    for j=1:400
        %find all values associated with high value and set high to output
        if( (pictureInput(i,j)==9)||(pictureInput(i,j)==8)||(pictureInput(i,j)==5)||(pictureInput(i,j)==4) )
            hold(i,j) = 1;
        end
    end
end
%set output
output=hold;
end
%threshold red
function output = ThresholdEmbedding(pictureMain,pictureInput,color)
%remove values except ones place
hold = pictureMain(:,:,color);
hold = rem(hold,10);
%create empty array of 0s
hold1 = zeros(400);
for i=1:400
    for j=1:400
        %reduce values above 250 to prevent going over data point
        hold1(i,j) = pictureMain(i,j,color) - hold(i,j);
        if( hold1(i,j) >= 250 )
            hold1(i,j) = hold1(i,j) - 20;
        end
        %fillter out values associated with high output
        if( hold(i,j)<=1 )
            hold(i,j) = hold(i,j) + 2;
        elseif( hold(i,j)>5 )
            hold(i,j) = hold(i,j) - 4;
        end
        %if picture input value high set associated high value
        if( pictureInput(i,j) == 1)
            if( hold(i,j) <= 5)
                hold(i,j) = hold(i,j) + 4;
            end
            %combine values for ones place and ten and above
            pictureMain(i,j,color) = hold1(i,j) + hold(i,j);
        end
    end
end
%set output
output = pictureMain;
end
function output = ThresholdRecovery(pictureInput,color)
%create empty array
hold = zeros(400);
%create array of only tens place
pictureInput = pictureInput(:,:,color);
pictureInput = rem(pictureInput,10);
for i=1:400
    for j=1:400
        %if value is above 6 set index high
        if( pictureInput(i,j) >= 6 )
            hold(i,j) = 1;
        end
    end
end
%set output
output=hold;
end
