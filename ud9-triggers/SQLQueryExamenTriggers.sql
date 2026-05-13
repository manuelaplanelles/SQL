create database FILM_PRODUCTION
--1.
create or alter trigger UPDATE_UNITS_PROP_DETAILS
on ORDERS_DETAILS
after INSERT
as begin
	declare @idProp smallint =(select IdProp from inserted)
	declare @quantity smallint =(select Quantity from inserted)
	declare @unitprice smallmoney =(select UnitPrice from inserted)

	UPDATE PROP
	set Stock = Stock + @quantity
	where IdProp = @idProp

	if (select Stock from PROP where IdProp = @idprop)
        <= (select FlagStock from PROP where IdProp = @idprop)
		begin
			update PROP
			set Flag = 1
			where IdProp = @idprop
		end
end

select * from ORDERS_DETAILS
select * from PROP

insert into ORDERS values (1, '18/04/2026')

insert into ORDERS_DETAILS values (7, 2, 4, 6)
insert into ORDERS_DETAILS values (7, 3, 3, 4.2)
insert into ORDERS_DETAILS values (7, 5, 5, 3)
--2.
create or alter trigger START_PREPARING_SCENE
on PREPARATION
after INSERT
as begin
	declare @idmovie smallint =(select IdMovie from inserted)
	declare @idscene smallint =(select IdScene from inserted)
	declare @dateprep date =(select DatePrep from inserted)

	if (select StatusScene from SCENE where IdMovie = @idmovie and IdScene = @idscene)='Pending'
		begin
			update SCENE
			set StatusScene = 'Prepared'
			where IdMovie = @idmovie and IdScene = @idscene
		end
end
--3.
create or alter trigger UPDATE_UNITS_PROP_USING_SCENE
on SCENE
after update
as begin
	declare @idmovie int =( select IdMovie from inserted)
	declare @idscene tinyint =( select IdScene from inserted)
	declare @statusold varchar (8) =( select StatusScene from deleted)
	declare @statusnew varchar (8) =( select StatusScene from inserted)

	declare @idprop int
	declare @quantity smallint

	if @statusold = 'Prepared' and @statusnew = 'Prepared'
		begin
			declare cursor_prepared cursor
			for select IdProp, Quantity
				from SCENE_PROP
				where IdScene = @idscene and IdMovie = @idmovie
			
			open cursor_prepared
			fetch next from cursor_prepared into @idprop, @quantity

			while @@FETCH_STATUS = 0
				begin
					update PROP
					set Stock=Stock-@quantity
					where IdProp = @idprop

					if (select Stock from PROP where IdProp = @idprop)<(select FlagStock from PROP where IdProp = @idprop)
						begin
							update PROP
							set Flag = 1
							where IdProp = @idprop
						end
					fetch next from cursor_prepared into @idprop, @quantity
				end
			close cursor_prepared
			deallocate cursor_prepared
		end
end
--4.
create or alter trigger FINISH_SCENE
on SCENE
after update
as begin
	declare @idmovie int =( select IdMovie from inserted)
	declare @idscene tinyint =( select IdScene from inserted)
	declare @statusold varchar (8) =( select StatusScene from deleted)
	declare @statusnew varchar (8) =( select StatusScene from inserted)

	declare @idprop int
	declare @quantity smallint
	declare @idemployee char(5)
	declare @hourlyrate tinyint
	declare @hoursprep tinyint
	declare @date date
	declare @salary money

	if @statusold = 'Prepared' and @statusnew = 'Prepared'
		begin
			declare cursor_prepared cursor
			for select IdProp, Quantity
				from SCENE_PROP
				where IdScene = @idscene and IdMovie = @idmovie
			
			open cursor_prepared
			fetch next from cursor_prepared into @idprop, @quantity

			while @@FETCH_STATUS = 0
				begin
					update PROP
					set Stock=Stock-@quantity
					where IdProp = @idprop

					if (select Stock from PROP where IdProp = @idprop)<(select FlagStock from PROP where IdProp = @idprop)
						begin
							update PROP
							set Flag = 1
							where IdProp = @idprop
						end
					fetch next from cursor_prepared into @idprop, @quantity
				end
			close cursor_prepared
			deallocate cursor_prepared

			declare cursor_employee cursor
			for select IdEmployee, DatePrep,HoursPrep
				from PREPARATION
				where IdScene = @idscene and IdMovie = @idmovie

			open cursor_employee
			fetch next from cursor_employee into @idemployee, @date, @hoursprep

			while @@FETCH_STATUS = 0
				begin
					set @hourlyrate = (select Hourly_Rate from EMPLOYEE
									    where IdEmployee = @idemployee)
					set @salary = @hourlyrate * @hoursprep 
					
					if exists (select IdEmployee from SALARY where IdEmployee=@idemployee and YearSal = year(@date) and MonthSal = month(@date))
						begin
							update SALARY
							set Salary = Salary + @salary
							where IdEmployee = @idemployee
							and YearSal = year(@date)
							and MonthSal = month(@date)
						end
					else
						begin
							insert into SALARY values (@idemployee, year(@date), month(@date),@salary)
						end 
					fetch next from cursor_employee into @idemployee, @date, @hoursprep
				end 
			close cursor_employee
			deallocate cursor_employee
		end
end