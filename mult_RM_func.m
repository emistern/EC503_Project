function [t1, t2, t3] = mult_RM_func(x,y,z)

    z = z(:); y= y(:); x=x(:);
    for i = 1:length(x)
        
        ind = 0;

        zi = z(i);
        yi = y(i);
        xi = x(i);    

        for j = 1:length(y)
            
            cnt = 0;

            if j == i
                continue;
            else
                zj = z(j);
                yj = y(j);
                xj = x(j);
            end
            ind = ind + 1;

            for k = 1:length(z)
                if (k == i || k == j)
                    continue;
                else
                    zk = z(k);
                    yk = y(k);
                    xk = x(k);
                end
                cnt = cnt + 1;

                t1_ijk(cnt) = det([zi,yi,1;zj,yj,1;zk,yk,1])/det([xi,yi,1;xj,yj,1;xk,yk,1]);                
                t2_ijk(cnt) = det([xi,zi,1;xj,zj,1;xk,zk,1])/det([xi,yi,1;xj,yj,1;xk,yk,1]);
                t3_ijk(cnt) = det([xi,yi,zi;xj,yj,zj;xk,yk,zk])/det([xi,yi,1;xj,yj,1;xk,yk,1]);

            end%k

            t1_ij(ind) = median(t1_ijk( ~isnan(t1_ijk)));
            t2_ij(ind) = median(t2_ijk(~isnan(t2_ijk)));
            t3_ij(ind) = median(t3_ijk(~isnan(t3_ijk)));
        end%j

        t1_i(i) = median(t1_ij(~isnan(t1_ij)));
        t2_i(i) = median(t2_ij(~isnan(t2_ij)));
        t3_i(i) = median(t2_ij(~isnan(t3_ij)));

    end%i

    t1 = median(t1_i(~isnan(t1_i)));
    t2 = median(t2_i(~isnan(t2_i)));
    t3 = median(t3_i(~isnan(t3_i)));

end
