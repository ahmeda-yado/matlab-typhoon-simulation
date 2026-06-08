classdef YourHandleClass < handle
    properties
        value
        lis  % リスト想定
    end
    methods
        function obj = YourHandleClass(val)
            obj.value = val;
            obj.lis = [];
        end
        function val_add(obj, num)  % objはpythonでいうselfみたいな？
            obj.value = obj.value + num;
        end
        function val_update(obj, num)
            obj.value = num;
        end
        function lis_add(obj, lis2)
            obj.lis = [obj.lis lis2];
        end
        function lis_update(obj, i, lis2)
            obj.lis(:, i) = lis2;
        end
        function lis_reset(obj, i)
            obj.lis(:, i) = 0;
        end
        function lis_delete(obj, i)
            obj.lis(:, i) = [];
        end
        function lis_recon(obj)            
            if isa(obj.lis, 'handle')  % このチェックがないとisvalid処理されない
                obj.lis = obj.lis(isvalid(obj.lis));
            else
                disp('lis_reconが適用されませんでした');
            end
        end
    end
end

