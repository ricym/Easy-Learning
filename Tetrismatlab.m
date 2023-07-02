% 设置游戏界面和方块参数
width = 10;
height = 20;
board = zeros(height, width);
block_size = 20;
shapes = {[0 1 0; 1 1 1], [1 1; 1 1], [1 0; 1 1; 0 1], ...
          [0 1; 1 1; 1 0], [1; 1; 1; 1], [1 1 0; 0 1 1], ...
          [0 1 1; 1 1 0]};

% 初始化游戏
score = 0;
next_shape = randi(length(shapes));
current_shape = randi(length(shapes));
current_rotation = randi(4);
current_pos = [1, width/2];

% 游戏循环
while true
    % 绘制游戏界面
    clf;
    for i = 1:height
        for j = 1:width
            if board(i, j) == 0
                rectangle('Position', [(j-1)*block_size, (height-i)*block_size, block_size, block_size], 'FaceColor', 'white');
            else
                rectangle('Position', [(j-1)*block_size, (height-i)*block_size, block_size, block_size], 'FaceColor', 'blue');
            end
        end
    end
    
    % 绘制当前方块
    shape = shapes{current_shape};
    rotation = mod(current_rotation-1, 4) + 1;
    shape = rot90(shape, rotation);
    for i = 1:size(shape, 1)
        for j = 1:size(shape, 2)
            if shape(i, j) == 1
                rectangle('Position', [(current_pos(2)+j-2)*block_size, (height-current_pos(1)-i)*block_size, block_size, block_size], 'FaceColor', 'red');
            end
        end
    end
    
    % 检查是否需要向下移动方块
    if any(current_pos(1)+size(shape, 1)-1 == height) || any(board(current_pos(1)+size(shape, 1)-1, current_pos(2)+(1:size(shape, 2))) > 0)
        board(current_pos(1)+(0:size(shape, 1)-1), current_pos(2)+(1:size(shape, 2))) = board(current_pos(1)+(0:size(shape, 1)-1), current_pos(2)+(1:size(shape, 2))) | shape;
        current_shape = next_shape;
        next_shape = randi(length(shapes));
        current_rotation = randi(4);
        current_pos = [1, width/2];
        if any(board(1, :))
            break;
        end
    else
        current_pos(1) = current_pos(1) + 1;
    end
    
    % 处理用户输入
    drawnow;
    pause(0.1);
    if kbhit
        key = getkey;
        if key == 'a' && current_pos(2) > 1 && all(board(current_pos(1)+(1:size(shape, 1))-1, current_pos(2)-1) == 0)
            current_pos(2) = current_pos(2) - 1;
        elseif key == 'd' && current_pos(2)+size(shape, 2) <= width && all(board(current_pos(1)+(1:size(shape, 1))-1, current_pos(2)+size(shape, 2)) == 0)
            current_pos(2) = current_pos(2) + 1;
        elseif key == 's'
            current_pos(1) = current_pos(1) + 1;
        elseif key == 'q'
            current_rotation = current_rotation - 1;
        elseif key == 'e'
            current_rotation = current_rotation + 1;
        end
    end
end

% 游戏结束
text(width*block_size/2, height*block_size/2, sprintf('Game Over\nScore: %d', score), 'HorizontalAlignment', 'center', 'FontSize', 36);