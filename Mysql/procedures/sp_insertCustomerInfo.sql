drop procedure sp_insertCustomerInfo;
delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertCustomerInfo`
						(in p_cfirstname varchar(30), in p_clastname varchar(30), 
						in p_cgender char(1), in p_cmaritality char(1), in p_cinstype char(1), 
                        in p_chouse int, in p_cstreet varchar(30), in p_ccity varchar(30), 
                        in p_cstate varchar(2), in p_czipcode int, in p_user_name varchar(45))
BEGIN
    if ( select exists 
		(select c.user_id from WDS.user u join WDS.customer c on u.user_id=c.user_id 
        where u.user_username = p_user_name) ) then 
        set @temp_id := (select c.user_id from WDS.user u join WDS.customer c on u.user_id=c.user_id 
						where u.user_username = p_user_name);
        update customer set cfirstname=p_cfirstname,clastname=p_clastname,cgender=p_cgender,cmaritality=p_cmaritality,
							cinstype=p_cinstype,chouse=p_chouse,cstreet=p_cstreet,ccity=p_ccity,cstate=p_cstate,
                            czipcode=p_czipcode where user_id=@temp_id;
     
    ELSE
		set @temp_id := (select user_id from WDS.user where user_username=p_user_name);
        insert into customer(cfirstname, clastname, cgender, cmaritality, cinstype, chouse, cstreet, ccity,
						cstate, czipcode, user_id) 
		values (p_cfirstname, p_clastname, p_cgender, p_cmaritality, p_cinstype,
                        p_chouse, p_cstreet, p_ccity, p_cstate, p_czipcode, @temp_id);
     
    END IF;
END$$
DELIMITER ;
