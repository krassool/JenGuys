function tower_plot(block_num,BlMat)

for k=1:block_num
        if rem(k-1,6)<3 %decide on the roattion of the block
            rot=0;
        else
            rot=90;
        end
    block_plot_rot([BlMat(k,:)],rot);
end



