Процедура ОбработкаПроведения(Отказ,Режим)//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	//Данный фрагмент построен конструктором.
	//При повторном использовании конструктора, внесенные вручную данные будут утеряны!

	// регистр РегистрНачисленияЗарплаты
	Перем ВыборДетальныеЗаписи;
	Движения.РегистрНачисленияЗарплаты.Записывать = Истина;
	Движение = Движения.РегистрНачисленияЗарплаты.Добавить();
	Движение.Сторно = Ложь;
	Движение.ВидРасчета = ПланыВидовРасчета.Начисления.ОкладПоТарифу;
	Движение.ПериодРегистрации = Дата;
	Движение.ПериодДействияНачало = НачалоМесяца(Дата);
	Движение.ПериодДействияКонец = КонецМесяца(Дата);
	Движение.Сотрудник = Сотрудник;
	Движение.РасчетныеДанные = ДневнойТариф;
	
	Движения.Записать();
	
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	РегистрНачисленияЗарплатыДанныеГрафика.РасчетныеДанные,
		|	РегистрНачисленияЗарплатыДанныеГрафика.РабочийДеньФактическийПериодДействия КАК Факт
		|ИЗ
		|	РегистрРасчета.РегистрНачисленияЗарплаты.ДанныеГрафика(Регистратор = &Ссылка) КАК
		|		РегистрНачисленияЗарплатыДанныеГрафика";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Если ВыборкаДетальныеЗаписи.Следующий() Тогда
		
		Результат = ВыборкаДетальныеЗаписи.РасчетныеДанные * ВыборкаДетальныеЗаписи.Факт;
		Движение.Результат = Результат;
	КонецЕсли;
	
	Движения.РегистрНачисленияЗарплаты.Записать();
	
	    Движения.ЗадолженностьПередСотрудниками.Записывать = Истина;
		Движение = Движения.ЗадолженностьПередСотрудниками.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Сотрудник = Сотрудник;
		Движение.Долг = Результат;
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА

	КонецПроцедуры