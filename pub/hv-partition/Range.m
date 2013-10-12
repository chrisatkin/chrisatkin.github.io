% -----------------------------------------
% Class representing a Range for partitioning
% -----------------------------------------
%
% @author		Chris Atkin-Granville
% @link			http://chrisatk.in
% @email		c.e.atkin-granville {at} sms.ed.ac.uk
%
% @file			hv_partition.m
% @version	1.0
% @date			26th January 2012
%
% Copyright (C) 2012 Chris Atkin-Granville.
% All rights reserved.
% -----------------------------------------

classdef Range < dynamicprops & handle
    properties
       global_pixels
       domain
       domain_sum
       
       height
       width
       x_range
       y_range
       turtle % the current segment "layer" number
       total_turtles % maximum number of layers
       draw
       uniq_id
       
       % Partition locations RELATIVE TO THE ENTIRE RANGE
       row_partition
       col_partition
       
       % Sub partitions are now dynamic properties, and added at runtime
       
       
       % Preallocations for speed
       row_means
       col_means
       row_differences
       col_differences
       row_biases
       col_biases
    end
    
    methods 
        % Constructor
        function obj = Range(range, x_range, y_range, turtle)
            obj.global_pixels = range;
            [obj.height obj.width] = size(obj.global_pixels);

            obj.x_range = x_range;
            obj.y_range = y_range;
            
            obj.turtle = turtle;
            obj.total_turtles = 4;
            
            % Pre-allocations
            obj.row_means = zeros(1, obj.height);
            obj.row_differences = zeros(1, obj.height);
            obj.row_biases = zeros(1, obj.height);
            obj.col_means = zeros(1, obj.width);
            obj.col_differences = zeros(1, obj.width);
            obj.col_biases = zeros(1, obj.width);
            
            obj.domain = obj.global_pixels(obj.y_range(1) : obj.y_range(2), obj.x_range(1) : obj.x_range(2));
            obj.domain_sum = sum(sum(obj.domain));
            
            % From the environment...
            global DRAW_FIGURE ID
            obj.draw = DRAW_FIGURE;
            obj.uniq_id = ID;
            ID = ID + 1;
        end
        
        % Partition
        function segment(obj, force)  
            % Check we're still in bounds
            if obj.turtle > obj.total_turtles
                return
            end
            
            % Ensure there's actually something to segment
            if(obj.domain_sum == 0)
                return
            end
            
            range_width = obj.x_range(2) - obj.x_range(1);
            range_height = obj.y_range(2) - obj.y_range(1);
            
            %fprintf('[%d] Width: %d Height: %d\n', obj.turtle, range_width, range_height);
            
            if range_width <= 4 || range_height <= 4
                %fprintf('[%d] Ending\n', obj.turtle);
                return
            end
            
            %fprintf('%g | x: [%g, %g] y: [%g, %g]\n', obj.uniq_id, obj.x_range(1), obj.x_range(2), obj.y_range(1), obj.y_range(2))
            
            % Get the domain
            %addprop(obj, 'domain');
            
            if isempty(obj.domain)
                throw MException('Domain is empty!!!');
            end
            
            % Calculate means
            obj.col_means(obj.x_range(1):obj.x_range(2)) = mean(obj.domain);
            obj.row_means(obj.y_range(1):obj.y_range(2)) = mean(obj.domain, 2);
            
            % Calculate differences between the means
            % Height first
            for i = 2 : obj.height
                obj.row_differences(i) = obj.row_means(i) - obj.row_means(i - 1);
            end
            
            for i = 2 : obj.width
                obj.col_differences(i) = obj.col_means(i) - obj.col_means(i - 1);
            end
            
            % Linear biases...
            for i = 1 : obj.height
                if i > obj.y_range(1) && i < obj.y_range(2)
                    if i - obj.y_range(1) <= (range_height / 2)
                        % The top edge is nearest
                        nearest = i - obj.y_range(1);
                    else
                        % Bottom edge is nearest
                        nearest = obj.y_range(2) - i;
                    end
                    
                    obj.row_biases(i) = abs(linear_bias(obj.row_differences(i), nearest));
                end
            end
            
           for i = 1 : obj.width
                if i > obj.x_range(1) && i < obj.x_range(2)
                    if i - obj.x_range(1) <= (range_width / 2)
                        % The top edge is nearest
                        nearest = i - obj.x_range(1);
                    else
                        % Bottom edge is nearest
                        nearest = obj.x_range(2) - i;
                    end
                    
                    obj.col_biases(i) = abs(linear_bias(obj.col_differences(i), nearest));
                end
           end
           
           % Partition locations
           % Note: it turns out the ~ syntax for ignoring returns is a new
           % feature beyond the capabilities of R2008b, so t is just a
           % temporary variable to get around this so I can develop in
           % Boole Lab. This should still work in R2010B/R2011A etc.
           [t, obj.row_partition] = max(obj.row_biases);
           [t, obj.col_partition] = max(obj.col_biases);
           
           %fprintf('[%d] Row: %d Col: %d\n', obj.turtle, obj.row_partition, obj.col_partition);
           
           if obj.draw
               % Vertical partition
               imline(gca, [obj.col_partition, obj.col_partition], [obj.y_range(1), obj.y_range(2)]);
           
               % Horizontal partition
               imline(gca, [obj.x_range(1), obj.x_range(2)], [obj.row_partition, obj.row_partition]);
           end
               
           % Create sub-ranges
           % This really shows why MATLABs object model is pants-on-head
           % retarded! Want instance properties? Why bother delcaraing them
           % as properties when one can use addprop?!
           addprop(obj, 'upper_left');
           addprop(obj, 'upper_right');
           addprop(obj, 'lower_left');
           addprop(obj, 'lower_right');
           
           % Actually assign the partitions
           obj.upper_left = Range(obj.global_pixels, [obj.x_range(1), obj.col_partition], [obj.y_range(1), obj.row_partition], obj.turtle + 1);
           obj.upper_right = Range(obj.global_pixels, [obj.col_partition, obj.x_range(2)], [obj.y_range(1), obj.row_partition], obj.turtle + 1);
           obj.lower_left = Range(obj.global_pixels, [obj.x_range(1), obj.col_partition], [obj.row_partition, obj.y_range(2)], obj.turtle + 1);
           obj.lower_right = Range(obj.global_pixels, [obj.col_partition, obj.x_range(2)], [obj.row_partition, obj.y_range(2)], obj.turtle + 1);
            
           % Segment!
           obj.upper_left.segment();
           obj.upper_right.segment();
           obj.lower_left.segment();
           obj.lower_right.segment();
        end
        
        function leaf = is_leaf(obj)
            % If the object has no segments, then it is a leaf.
            leaf = not(property_exists(obj, 'upper_left') || property_exists(obj, 'upper_right') || property_exists(obj, 'lower_left') || property_exists(obj, 'lower_right'));
        end
        
        function get_leaves(obj)
           global leaves
           
           % Check if there are any leaves
           if obj.is_leaf()
               % There aren't, so there's nothing to except keep going down
               % the rabbit hole.
               return
           else
               % Okay, there's at least one leaf, so check which one.
               % Upper left
               %obj.upper_left
               if obj.upper_left.is_leaf()
                   leaves{numel(leaves) + 1} = obj.upper_left;
               else
                   obj.upper_left.get_leaves();
               end
                
               % Upper right
               if obj.upper_right.is_leaf()
                   leaves{numel(leaves) + 1} = obj.upper_right;
               else
                   obj.upper_right.get_leaves();
               end
                   
               % Lower left
               if obj.lower_left.is_leaf()
                   leaves{numel(leaves) + 1} = obj.lower_left;
               else
                   obj.lower_left.get_leaves();
               end
               
               % Lower right
               if obj.lower_right.is_leaf()
                   leaves{numel(leaves) + 1} = obj.lower_right;
               else
                   obj.lower_right.get_leaves();
               end 
           end
        end
        
        % This function takes a cell array of leaves (generated by
        % get_leaves() and compares it to every leaf node in the tree.
        function map_leaves(obj, leaves)
            global THRESHOLD
            
            if obj.is_leaf()
                fprintf('Domain is %g\n', obj.uniq_id)
                
                % Okay, we're on a leaf. Check all the domains.
                % Parallel for speed
                
                current_uniq_id = obj.uniq_id;
                current_domain_sum = obj.domain_sum;
                
                % Find the resource
                rsrc = findResource();
                
                % Create jobs
                
                
                % Dispatch jobs.
%                 for i = 1 : numel(leaves) - 1
%                     % Ensure we're not in the current leaf
%                     if current_uniq_id == leaves{i}.uniq_id
%                         continue
%                     else
%                         delta = compare_domain_range(current_domain_sum, leaves{i}.domain_sum);
%                         
%                         %fprintf('%g -> %g: %f\n', obj.uniq_id, leaves{i}.uniq_id, delta)
%                         
%                         % Check against the treshold
%                         if delta <= THRESHOLD
%                             % There is now a mapping between obj and
%                             % leaves(i).
%                         else
%                             % Segment the image some more
%                             %obj.segment(true);
%                             
%                             %
%                         end
%                     end
%                 end
            else
               % No leaf here, so down the rabbit hole we go
               obj.upper_left.map_leaves(leaves);
               obj.upper_right.map_leaves(leaves);
               obj.lower_left.map_leaves(leaves);
               obj.lower_right.map_leaves(leaves);
            end
        end
    end
end