/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_pegawai_pembentukan_data_awal_guru;
var m_adm_pegawai_pembentukan_data_awal_guru_list;
var m_adm_pegawai_pembentukan_data_awal_guru_detail;
var m_adm_pegawai_pembentukan_data_awal_guru_id_pegawai = '';
var m_adm_pegawai_pembentukan_data_awal_guru_d = _g_root +'/module/adm_pegawai_pembentukan_data_awal_guru/';
var m_adm_pegawai_pembentukan_data_awal_guru_ha_level = 0;

function M_AdmPegawaiPembentukanDataAwalGuruDetail()
{
	this.dml_type	= 0;

	this.store_jenis_kelamin = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['1','Laki-Laki']
			,	['2','Perempuan']
			]
		,	idIndex		: 0
	});

	this.store_agama = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_pembentukan_data_awal_guru_d +'data_ref_agama.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_gol_darah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_pembentukan_data_awal_guru_d +'data_ref_gol_darah.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_status_nikah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['N','Menikah']
			,	['J','Janda']
			,	['D','Duda']
			,	['B','Belum Menikah']
			]
		,	idIndex		: 0
	});

	this.store_jenis_ketenagaan = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_pembentukan_data_awal_guru_d +'data_ref_jenis_ketenagaan.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_operasi_komputer = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['0','Belum Mampu Mengoperasikan']
			,	['1','Sudah Mampu Mengoperasikan']
			]
		,	idIndex		: 0
	});

	this.store_kursus_komputer = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['0','Belum Pernah']
			,	['1','Pernah']
			]
		,	idIndex		: 0
	});

	this.store_sertifikasi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['0','Belum']
			,	['1','Sudah']
			]
		,	idIndex		: 0
	});

	this.form_nip = new Ext.form.TextField({
			fieldLabel		: 'NIP'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 18
		,	maxLengthText	: 'Maksimal panjang kolom adalah 18'
		,	width			: 150
		,	msgTarget		: 'side'
		,	listeners		: {
				change	: function(form, newvalue, oldvalue) {
					this.foto.el.dom.src = _g_root + '/images/foto_guru/' + newvalue + '.jpg';
				}
			,	scope	: this
			}
	});

	this.form_nuptk = new Ext.form.NumberField({
			fieldLabel		: 'NUPTK'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 16
		,	maxLengthText	: 'Maksimal panjang kolom adalah 16'
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_nm_pegawai = new Ext.form.TextField({
			fieldLabel		: 'Nama Guru'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_inisial = new Ext.form.TextField({
			fieldLabel		: 'Inisial'
		,	allowBlank		: false
		,	maxLength		: 3
		,	maxLengthText	: 'Maksimal panjang kolom adalah 3'
		,	width			: 30
		,	msgTarget		: 'side'
	});

	this.form_kota_lahir = new Ext.form.TextField({
			fieldLabel		: 'Kota Lahir'
		,	allowBlank		: false
		,	width			: 250
		,	msgTarget		: 'side'
	});

	this.form_tanggal_lahir = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Lahir'
		,	emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_jenis_kelamin = new Ext.form.ComboBox({
			fieldLabel		: 'Jenis Kelamin'
		,	store			: this.store_jenis_kelamin
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_agama = new Ext.form.ComboBox({
			fieldLabel		: 'Agama'
		,	store			: this.store_agama
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_alamat = new Ext.form.TextArea({
			fieldLabel		: 'Alamat'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_kode_pos = new Ext.form.NumberField({
			fieldLabel		: 'Kode Pos'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 5
		,	maxLengthText	: 'Maksimal panjang kolom adalah 5'
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_gol_darah = new Ext.form.ComboBox({
			fieldLabel		: 'Gol.Darah'
		,	store			: this.store_gol_darah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_no_telp = new Ext.form.NumberField({
			fieldLabel		: 'No.Telepon'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 30
		,	maxLengthText	: 'Maksimal panjang kolom adalah 30'
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_no_hp = new Ext.form.NumberField({
			fieldLabel		: 'No.HP'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 30
		,	maxLengthText	: 'Maksimal panjang kolom adalah 30'
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_status_nikah = new Ext.form.ComboBox({
			fieldLabel		: 'Status Nikah'
		,	store			: this.store_status_nikah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_jenis_ketenagaan = new Ext.form.ComboBox({
			fieldLabel		: 'Jenis Ketenagaan'
		,	store			: this.store_jenis_ketenagaan
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_operasi_komputer = new Ext.form.ComboBox({
			fieldLabel		: 'Operasi Komputer'
		,	store			: this.store_operasi_komputer
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_kursus_komputer = new Ext.form.ComboBox({
			fieldLabel		: 'Kursus Komputer'
		,	store			: this.store_kursus_komputer
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_sertifikasi = new Ext.form.ComboBox({
			fieldLabel		: 'Sertifikasi'
		,	store			: this.store_sertifikasi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.foto = new Ext.BoxComponent({
		anchor		: ''
	,	fieldLabel	: 'Foto (130px X 170px)'
	,	isFormField	: true
	,	height		: 170
	,	width		: 130
	,	autoEl		: {
			tag	: 'img'
		,	src	: _g_root + '/images/foto_guru/default.gif'
		}
	});
	
	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 175
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_nip
				,	this.foto					
				,	this.form_nuptk
				,	this.form_nm_pegawai
				,	this.form_inisial
				,	this.form_kota_lahir
				,	this.form_tanggal_lahir
				,	this.form_jenis_kelamin
				,	this.form_agama
				,	this.form_alamat
				,	this.form_kode_pos
				,	this.form_gol_darah
				,	this.form_no_telp
				,	this.form_no_hp
				,	this.form_status_nikah
				,	this.form_jenis_ketenagaan
				,	this.form_operasi_komputer
				,	this.form_kursus_komputer
				,	this.form_sertifikasi
			]
	});

	this.btn_back = new Ext.Button({
			text	: 'Kembali'
		,	iconCls	: 'back16'
		,	scope	: this
		,	handler	: function() {
				this.do_back();
			}
	});

	this.btn_save	= new Ext.Button({
			text	: 'Simpan'
		,	iconCls	: 'save16'
		,	scope	: this
		,	handler	: function() {
				this.do_save();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_back
		,	'->'
		,	this.btn_save
		]
	});

	this.panel = new Ext.Panel({
			autoWidth	: true
		,	autoScroll	: true
		,	padding		:'6'
		,	tbar		: this.toolbar
		,	defaults	:{
				style		:{
					marginLeft		:'auto'
				,	marginRight		:'auto'
				,	marginBottom	:'8px'
				}
			}
		,	items		: [
				this.panel_form
			]
	});

	this.do_reset = function()
	{
		this.form_nip.setValue('');
		this.form_nuptk.setValue('');
		this.form_nm_pegawai.setValue('');
		this.form_inisial.setValue('');
		this.form_kota_lahir.setValue('');
		this.form_tanggal_lahir.setValue('');
		this.form_jenis_kelamin.setValue('');
		this.form_agama.setValue('');
		this.form_alamat.setValue('');
		this.form_kode_pos.setValue('');
		this.form_gol_darah.setValue('');
		this.form_no_telp.setValue('');
		this.form_no_hp.setValue('');
		this.form_status_nikah.setValue('');
		this.form_jenis_ketenagaan.setValue('');
		this.form_operasi_komputer.setValue('');
		this.form_kursus_komputer.setValue('');
		this.form_sertifikasi.setValue('');
		
		this.foto.el.dom.src = _g_root + '/images/foto_guru/default.gif'
	}

	this.edit_fill_form = function(data)
	{
		this.form_nip.setValue(data.nip);
		this.form_nuptk.setValue(data.nuptk);
		this.form_nm_pegawai.setValue(data.nm_pegawai);
		this.form_inisial.setValue(data.inisial);
		this.form_kota_lahir.setValue(data.kota_lahir);
		this.form_tanggal_lahir.setValue(data.tanggal_lahir);
		this.form_jenis_kelamin.setValue(data.kd_jenis_kelamin);
		this.form_agama.setValue(data.kd_agama);
		this.form_alamat.setValue(data.alamat);
		this.form_kode_pos.setValue(data.kd_pos);
		this.form_gol_darah.setValue(data.kd_gol_darah);
		this.form_no_telp.setValue(data.no_telp);
		this.form_no_hp.setValue(data.no_hp);
		this.form_status_nikah.setValue(data.kd_status_nikah);
		this.form_jenis_ketenagaan.setValue(data.kd_jenis_ketenagaan);
		this.form_operasi_komputer.setValue(data.operasi_komputer);
		this.form_kursus_komputer.setValue(data.kursus_komputer);
		this.form_sertifikasi.setValue(data.sertifikasi);
		
		this.foto.el.dom.src = _g_root + '/images/foto_guru/' + this.form_nip.getValue() + '.jpg'
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;

		Ext.Ajax.request({
			url		: m_adm_pegawai_pembentukan_data_awal_guru_d +'data.jsp'
		,	params	: {
				id_pegawai	: m_adm_pegawai_pembentukan_data_awal_guru_id_pegawai
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
					return;
				}

				this.edit_fill_form(msg);
			}
		,	scope	: this
		});
	}

	this.do_back = function()
	{
		m_adm_pegawai_pembentukan_data_awal_guru.panel.layout.setActiveItem(0);
	}

	this.is_valid = function()
	{
		if (!this.form_nip.isValid()) {
			return false;
		}

		if (!this.form_nm_pegawai.isValid()) {
			return false;
		}

		if (!this.form_inisial.isValid()) {
			return false;
		}

		if (!this.form_kota_lahir.isValid()) {
			return false;
		}

		if (!this.form_tanggal_lahir.isValid()) {
			return false;
		}

		if (!this.form_jenis_kelamin.isValid()) {
			return false;
		}

		if (!this.form_agama.isValid()) {
			return false;
		}

		if (!this.form_alamat.isValid()) {
			return false;
		}

		if (!this.form_gol_darah.isValid()) {
			return false;
		}

		if (!this.form_status_nikah.isValid()) {
			return false;
		}

		if (!this.form_jenis_ketenagaan.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		main_load.show();
		
		Ext.Ajax.request({
				url		: m_adm_pegawai_pembentukan_data_awal_guru_d +'submit.jsp'
			,	params  : {
						id_pegawai						: m_adm_pegawai_pembentukan_data_awal_guru_id_pegawai
					,	nip				: this.form_nip.getValue()
					,	nomor_induk				: '1'
					,	nuptk					: this.form_nuptk.getValue()
					,	nm_pegawai				: this.form_nm_pegawai.getValue()
					,	inisial					: this.form_inisial.getValue()
					,	kota_lahir				: this.form_kota_lahir.getValue()
					,	tanggal_lahir			: this.form_tanggal_lahir.getValue()
					,	kd_jenis_kelamin		: this.form_jenis_kelamin.getValue()
					,	kd_agama				: this.form_agama.getValue()
					,	alamat					: this.form_alamat.getValue()
					,	kd_pos					: this.form_kode_pos.getValue()
					,	kd_gol_darah			: this.form_gol_darah.getValue()
					,	no_telp					: this.form_no_telp.getValue()
					,	no_hp					: this.form_no_hp.getValue()
					,	kd_status_nikah			: this.form_status_nikah.getValue()
					,	kd_jenis_ketenagaan		: this.form_jenis_ketenagaan.getValue()
					,	operasi_komputer		: this.form_operasi_komputer.getValue()
					,	kursus_komputer			: this.form_kursus_komputer.getValue()
					,	sertifikasi				: this.form_sertifikasi.getValue()
					,	dir_foto				: '1'
					,	dml_type				: this.dml_type
				}
			,	waitMsg	: 'Mohon Tunggu ...'
			,	failure	: function(response) {
					main_load.hide();
					Ext.MessageBox.alert('Gagal', response.responseText);
				}
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						main_load.hide();
						
						Ext.MessageBox.alert('Informasi', msg.info);

						m_adm_pegawai_pembentukan_data_awal_guru_list.store.reload();
						m_adm_pegawai_pembentukan_data_awal_guru.panel.layout.setActiveItem(0);
					}
			,	scope	: this
		});
	}

	this.do_refresh = function()
	{
		this.store_agama.load();
		this.store_gol_darah.load();
		this.store_jenis_ketenagaan.load();
	}
}

function M_AdmPegawaiPembentukanDataAwalGuruList()
{
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_pegawai' }
		,	{ name	: 'nip' }
		,	{ name	: 'nm_pegawai' }
		,	{ name	: 'kd_jenis_ketenagaan' }
		,	{ name	: 'alamat' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_pegawai_pembentukan_data_awal_guru_d +'data_list.jsp'
		,	autoLoad	: false
	});

	this.store_jenis_ketenagaan = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_pembentukan_data_awal_guru_d +'data_ref_jenis_ketenagaan.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});
	
	/* form items */
	this.form_jenis_ketenagaan = new Ext.form.ComboBox({
			store			: this.store_jenis_ketenagaan
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});
	
	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,	{ header		: 'NIP'
			, dataIndex		: 'nip'
			, width			: 120
			, filterable	: true
			}
		,	{ header		: 'Nama Guru'
			, dataIndex		: 'nm_pegawai'
			, width			: 250
			, filterable	: true
			}
		,	{ header		: 'Jenis Ketenagaan'
			, dataIndex		: 'kd_jenis_ketenagaan'
			, editor		: this.form_jenis_ketenagaan
			, renderer		: combo_renderer(this.form_jenis_ketenagaan)
			, align			: 'center'
			, width			: 120
			, filter		: {
					type		: 'list'
				,	store		: this.store_jenis_ketenagaan
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ id			: 'alamat'
			, header		: 'Alamat'
			, dataIndex		: 'alamat'
			, filterable	: true
			}
		]
	,	defaults : {
			hideable	: false
		,	sortable	: true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length){
						m_adm_pegawai_pembentukan_data_awal_guru_id_pegawai = data[0].data['id_pegawai'];
						
						if (m_adm_pegawai_pembentukan_data_awal_guru_ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
					} else {
						m_adm_pegawai_pembentukan_data_awal_guru_id_pegawai = '';
						this.btn_del.setDisabled(true);
					}
				}
			}
	});

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
	});

	this.btn_edit = new Ext.Button({
			text	: 'Ubah'
		,	iconCls	: 'edit16'
		,	scope	: this
		,	handler	: function() {
				this.do_edit();
			}
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			// this.btn_del
		// ,	'-'
			this.btn_edit
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.panel = new Ext.grid.GridPanel({
			region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	cm					: this.cm
		,	autoScroll			: true
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'alamat'
	});

	this.do_del = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.Ajax.request({
			url		: m_adm_pegawai_pembentukan_data_awal_guru_d +'submit.jsp'
		,	params	: {
				dml_type				: 4
			,	id_pegawai						: data.get('id_pegawai')
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Kesalahan', msg.info);
					return;
				}

				Ext.MessageBox.alert('Informasi', msg.info);

				this.do_load();
			}
		,	scope	: this
		});
	}

	this.do_edit = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_adm_pegawai_pembentukan_data_awal_guru_detail.do_refresh();
		m_adm_pegawai_pembentukan_data_awal_guru_detail.do_edit(data.get('id_pegawai'));
		m_adm_pegawai_pembentukan_data_awal_guru.panel.layout.setActiveItem(1);
	}

	this.do_add = function()
	{
		m_adm_pegawai_pembentukan_data_awal_guru_detail.do_add();
		m_adm_pegawai_pembentukan_data_awal_guru_detail.do_refresh();
		m_adm_pegawai_pembentukan_data_awal_guru.panel.layout.setActiveItem(1);
	}
	
	this.do_load = function()
	{
		this.store_jenis_ketenagaan.load({
			callback	: function(){
				this.store.load();
			}
		,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_adm_pegawai_pembentukan_data_awal_guru_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_pegawai_pembentukan_data_awal_guru_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		if (m_adm_pegawai_pembentukan_data_awal_guru_ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (m_adm_pegawai_pembentukan_data_awal_guru_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		this.do_load();
	}
}

function M_AdmPegawaiPembentukanDataAwalGuru(title)
{
	m_adm_pegawai_pembentukan_data_awal_guru_list	= new M_AdmPegawaiPembentukanDataAwalGuruList();
	m_adm_pegawai_pembentukan_data_awal_guru_detail	= new M_AdmPegawaiPembentukanDataAwalGuruDetail();
	
	this.panel = new Ext.Panel({
			id				: 'adm_pegawai_pembentukan_data_awal_guru_panel'
		,	title			: title
		,	layout			: 'card'
		,	activeItem		: 0
		,	autoWidth		: true
		,	autoScroll		: true
		,	items			: [
				m_adm_pegawai_pembentukan_data_awal_guru_list.panel
			,	m_adm_pegawai_pembentukan_data_awal_guru_detail.panel
			]
	});
	
	this.do_refresh = function(ha_level)
	{
		m_adm_pegawai_pembentukan_data_awal_guru_ha_level = ha_level;
		
		m_adm_pegawai_pembentukan_data_awal_guru_list.do_refresh();
	}
}

m_adm_pegawai_pembentukan_data_awal_guru = new M_AdmPegawaiPembentukanDataAwalGuru('Pembentukan Data Awal Guru');

//@ sourceURL=adm_pegawai_pembentukan_data_awal_guru.layout.js
