                for i=1:numberOfImages
                    filename=[num2str(i), '.tif'];
                    rgbImage=imread(filename, 'tif');                      
                    R = rgbImage(row, col, 1);
                    G = rgbImage(row, col, 2);
                    B = rgbImage(row, col, 3);
                    RGBMatrix(i,:) =[R,G,B];
                end
                    for imageNumber=1:numberOfImages
                        match=0;
                        jitter=0;
                        for j=numberOfImages:-1:1   
                                RedChannelDifference=abs(double(RGBMatrix(j,1))-double(RGBMatrix(imageNumber,1)));
                                GreenChannelDifference=abs(double(RGBMatrix(j,2))-double(RGBMatrix(imageNumber,2)));
                                BlueChannelDifference=abs(double(RGBMatrix(j,3))-double(RGBMatrix(imageNumber,3)));
                                    if (RedChannelDifference+GreenChannelDifference+BlueChannelDifference)<=10
                                                jitter=jitter+RedChannelDifference+GreenChannelDifference+BlueChannelDifference;
                                                match=match+1;
                                    end
                        end
                        match=match-1;
                        matchMatrixOfAllImages(imageNumber,:)=[match];
                    end
                    %fprintf('The maximum value of matches is : %d \n', max(matchMatrixOfAllImages(:)));
                    index=find(matchMatrixOfAllImages == max(matchMatrixOfAllImages(:)));
                     if size(index,1)>1
                         jitterMatrixOfAllImages(imageNumber,:)=[jitter];  
                        % fprintf('Jitter values of ONLY MATCHES');
                         jitterMatrixOfMatchedImages=jitterMatrixOfAllImages(index,:);
                         indexForJitter=find(jitterMatrixOfMatchedImages == min(jitterMatrixOfMatchedImages(:)));
                            if size(indexForJitter,1)>1
                                indexOfPictureNeeded=indexForJitter(1,:);
                                filenameOfImage1=[num2str(indexOfPictureNeeded), '.tif'];
                                rgbImage1=imread(filename, 'tif');         
                                R1 = rgbImage1(row, col, 1);
                                G1 = rgbImage1(row, col, 2);
                                B1 = rgbImage1(row, col, 3);
                                RGBMatrix1(indexOfPictureNeeded,:) =[R1,G1,B1];
                                k=k+1;
                                out(k,:) =[R1,G1,B1]; 
                            else
                               indexOfPictureNeeded=indexForJitter(1,:);
                                filenameOfImage1=[num2str(indexOfPictureNeeded), '.tif'];
                                rgbImage1=imread(filename, 'tif');         
                                R1 = rgbImage1(row, col, 1);
                                G1 = rgbImage1(row, col, 2);
                                B1 = rgbImage1(row, col, 3);
                                RGBMatrix1(indexOfPictureNeeded,:) =[R1,G1,B1]; 
                                k=k+1;
                                out(k,:) =[R1,G1,B1]; 
                            end
                     else
                                jitterMatrixOfAllImages(imageNumber,:)=[jitter];  
                                jitterMatrixOfMatchedImages=jitterMatrixOfAllImages(index,:);
                                indexForJitter=find(jitterMatrixOfMatchedImages == min(jitterMatrixOfMatchedImages(:)));
                                indexOfPictureNeeded1=indexForJitter(1,:);  
                                filename1=[num2str(indexOfPictureNeeded1), '.tif'];
                               rgbImage2=imread(filename, 'tif');                      
                                R1 = rgbImage2(row, col, 1);
                                  G1 = rgbImage2(row, col, 2);
                                B1 = rgbImage2(row, col, 3);
                                RGBMatrix2(indexOfPictureNeeded1,:) =[R1,G1,B1];
                                k=k+1;
                                 out(k,:) =[R1,G1,B1]; 
                     end