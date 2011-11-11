/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_siswa_pembentukan_data_awal_siswa_pindahan;
var m_adm_siswa_pembentukan_data_awal_siswa_pindahan_list;
var m_adm_siswa_pembentukan_data_awal_siswa_pindahan_detail;
var m_adm_siswa_pembentukan_data_awal_siswa_pindahan_id_siswa = '';
var m_adm_siswa_pembentukan_data_awal_siswa_pindahan_d = _g_root +'/module/adm_siswa_pembentukan_data_awal_siswa_pindahan/';
var m_adm_siswa_pembentukan_data_awal_siswa_pindahan_ha_level = 0;

function M_AdmSiswaPembentukanDataAwalSiswaPindahanDetail()
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
		,	url			: m_adm_siswa_pembentukan_data_awal_siswa_pindahan_d +'data_ref_agama.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_hubungi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['1','Ayah']
			,	['2','Ibu']
			,	['3','Wali Siswa']
			]
		,	idIndex		: 0
	});

	this.store_tanggung_biaya = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['1','Ayah']
			,	['2','Ibu']
			,	['3','Wali']
			,	['4','Sendiri']
			]
		,	idIndex		: 0
	});

	this.store_gol_darah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pembentukan_data_awal_siswa_pindahan_d +'data_ref_gol_darah.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_asal_smp = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pembentukan_data_awal_siswa_pindahan_d +'data_ref_asal_smp.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_tingkat_kelas = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pembentukan_data_awal_siswa_pindahan_d +'data_ref_tingkat_kelas.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_nis = new Ext.form.TextField({
			fieldLabel		: 'Nomor Induk'
		,	allowBlank		: false
		,	maxLength		: 12
		,	maxLengthText	: 'Maksimal panjang kolom adalah 12'
		,	width			: 130
		,	msgTarget		: 'side'
		,	listeners		: {
				change	: function(form, newvalue, oldvalue) {
					this.foto.el.dom.src = _g_root + '/images/foto_siswa/' + left(newvalue, 2) + '/' + newvalue + '.jpg';
				}
			,	scope	: this
			}
	});

	this.form_nm_siswa = new Ext.form.TextField({
			fieldLabel		: 'Nama Siswa'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_nm_panggilan = new Ext.form.TextField({
			fieldLabel		: 'Nama Panggilan'
		,	allowBlank		: false
		,	maxLength		: 20
		,	maxLengthText	: 'Maksimal panjang kolom adalah 20'
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_kota_lahir = new Ext.form.TextField({
			fieldLabel		: 'Tempat Lahir'
		,	allowBlank		: false
		,	width			: 200
	});

	this.form_tanggal_lahir = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Lahir'
		,	emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
		,	width			: 150
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
		,	width			: 150
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

	this.form_rt = new Ext.form.NumberField({
			fieldLabel		: 'RT'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 3
		,	maxLengthText	: 'Maksimal panjang kolom adalah 3'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_rw = new Ext.form.NumberField({
			fieldLabel		: 'RW'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 3
		,	maxLengthText	: 'Maksimal panjang kolom adalah 3'
		,	width			: 50
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

	this.form_no_telp = new Ext.form.NumberField({
			fieldLabel		: 'No.Telepon'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 30
		,	maxLengthText	: 'Maksimal panjang kolom adalah 30'
		,	width			: 190
		,	msgTarget		: 'side'
	});

	this.form_no_hp = new Ext.form.NumberField({
			fieldLabel		: 'No.HP'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 30
		,	maxLengthText	: 'Maksimal panjang kolom adalah 30'
		,	width			: 190
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


	this.form_asal_smp = new Ext.form.ComboBox({
			fieldLabel		: 'Dari Sekolah'
		,	store			: this.store_asal_smp
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 300
		,	listWidth		: 400
		,	msgTarget		: 'side'
	});

	this.form_pindah_alasan = new Ext.form.TextArea({
			fieldLabel		: 'Alasan'
		,	allowBlank		: true
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_tingkat_kelas = new Ext.form.ComboBox({
			fieldLabel		: 'Di Tingkat'
		,	store			: this.store_tingkat_kelas
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

	this.form_diterima_tanggal = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Diterima'
		,	emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
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
		,	src	: _g_root + '/images/foto_siswa/default.gif'
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
					this.form_nis
				,	this.foto			
				,	{
						xtype		: 'fieldset'
					,	title		: 'Keterangan Tentang Diri Siswa'
					,	collapsible	: true
					,	items		: [
							this.form_nm_siswa
						,	this.form_nm_panggilan
						,	{
								xtype		: 'compositefield'
							,	fieldLabel	: 'Tempat dan Tanggal Lahir'
							,	msgTarget	: 'under'
							,	items		: [
									this.form_kota_lahir
								,	{
										xtype	: 'displayfield'
									,	value	: '-'
									}
								,	this.form_tanggal_lahir
								]
							}
						,	this.form_jenis_kelamin
						,	this.form_agama
						]
					}
				,	{
						xtype		: 'fieldset'
					,	title		: 'Keterangan Tempat Tinggal'
					,	collapsible	: true
					,	items		: [
							this.form_alamat
						,	{
								xtype		: 'compositefield'
							,	fieldLabel	: 'RT'
							,	items		: [
									this.form_rt
								,	{
										xtype	: 'displayfield'
									,	value	: 'RW :'
									}
								,	this.form_rw
								,	{
										xtype	: 'displayfield'
									,	value	: 'Kode Pos :'
									}
								,	this.form_kode_pos
								]
							}
						,	{
								xtype		: 'compositefield'
							,	fieldLabel	: 'No.Telp / HP'
							,	items		: [
									this.form_no_telp
								,	{
										xtype	: 'displayfield'
									,	value	: '/'
									}
								,	this.form_no_hp
								]
							}
						]
					}
				,	{
						xtype		: 'fieldset'
					,	title		: 'Keterangan Kesehatan'
					,	collapsible	: true
					,	items		: [
							this.form_gol_darah
						]
					}
				,	{
						xtype		: 'fieldset'
					,	title		: 'Keterangan Pendidikan'
					,	collapsible	: true
					,	items		: [
							{
								xtype		: 'displayfield'
							,	fieldLabel	: 'Pindahan'
							,	value		: ''
							}
						,	this.form_asal_smp
						,	this.form_pindah_alasan
						,	{
								xtype		: 'displayfield'
							,	fieldLabel	: 'Diterima di Sekolah ini'
							,	value		: ''
							}
						,	this.form_tingkat_kelas
						,	this.form_diterima_tanggal
						]
					}
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
		this.form_nis.setValue('');
		this.form_nm_siswa.setValue('');
		this.form_nm_panggilan.setValue('');
		this.form_kota_lahir.setValue('');
		this.form_tanggal_lahir.setValue('');
		this.form_jenis_kelamin.setValue('');
		this.form_agama.setValue('');
		this.form_alamat.setValue('');
		this.form_rt.setValue('');
		this.form_rw.setValue('');
		this.form_kode_pos.setValue('');
		this.form_no_telp.setValue('');
		this.form_no_hp.setValue('');
		this.form_gol_darah.setValue('');
		this.form_asal_smp.setValue('');
		this.form_pindah_alasan.setValue('');
		this.form_tingkat_kelas.setValue('');
		this.form_diterima_tanggal.setValue('');
		
		this.foto.el.dom.src = _g_root + '/images/foto_siswa/default.gif'
	}

	this.edit_fill_form = function(data)
	{
		this.form_nis.setValue(data.nis);
		this.form_nm_siswa.setValue(data.nm_siswa);
		this.form_nm_panggilan.setValue(data.nm_panggilan);
		this.form_kota_lahir.setValue(data.kota_lahir);
		this.form_tanggal_lahir.setValue(data.tanggal_lahir);
		this.form_jenis_kelamin.setValue(data.kd_jenis_kelamin);
		this.form_agama.setValue(data.kd_agama);
		this.form_alamat.setValue(data.alamat);
		this.form_rt.setValue(data.rt);
		this.form_rw.setValue(data.rw);
		this.form_kode_pos.setValue(data.kd_pos);
		this.form_no_telp.setValue(data.no_telp);
		this.form_no_hp.setValue(data.no_hp);
		this.form_gol_darah.setValue(data.kd_gol_darah);
		this.form_asal_smp.setValue(data.asal_smp);
		this.form_pindah_alasan.setValue(data.pindah_alasan);
		this.form_tingkat_kelas.setValue(data.kd_tingkat_kelas);
		this.form_diterima_tanggal.setValue(data.diterima_tanggal);

		this.foto.el.dom.src = _g_root + '/images/foto_siswa/' + left(this.form_nis.getValue(), 2) + '/' + this.form_nis.getValue() + '.jpg'
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
			url		: m_adm_siswa_pembentukan_data_awal_siswa_pindahan_d +'data.jsp'
		,	params	: {
				id_siswa	: m_adm_siswa_pembentukan_data_awal_siswa_pindahan_id_siswa
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
		m_adm_siswa_pembentukan_data_awal_siswa_pindahan.panel.layout.setActiveItem(0);
	}

	this.is_valid = function()
	{
		if (!this.form_nis.isValid()) {
			return false;
		}

		if (!this.form_nm_siswa.isValid()) {
			return false;
		}

		if (!this.form_nm_panggilan.isValid()) {
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

		if (!this.form_asal_smp.isValid()) {
			return false;
		}

		if (!this.form_tingkat_kelas.isValid()) {
			return false;
		}

		if (!this.form_diterima_tanggal.isValid()) {
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
				url		: m_adm_siswa_pembentukan_data_awal_siswa_pindahan_d +'submit.jsp'
			,	params  : {
						id_siswa					: m_adm_siswa_pembentukan_data_awal_siswa_pindahan_id_siswa
					,	nis							: this.form_nis.getValue()
					,	nm_siswa					: this.form_nm_siswa.getValue()
					,	nm_panggilan				: this.form_nm_panggilan.getValue()
					,	kota_lahir					: this.form_kota_lahir.getValue()
					,	tanggal_lahir				: this.form_tanggal_lahir.getValue()
					,	kd_jenis_kelamin			: this.form_jenis_kelamin.getValue()
					,	kd_agama					: this.form_agama.getValue()
					,	alamat						: this.form_alamat.getValue()
					,	rt							: this.form_rt.getValue()
					,	rw							: this.form_rw.getValue()
					,	kd_pos						: this.form_kode_pos.getValue()
					,	no_telp						: this.form_no_telp.getValue()
					,	no_hp						: this.form_no_hp.getValue()
					,	kd_gol_darah				: this.form_gol_darah.getValue()
					,	asal_smp					: this.form_asal_smp.getValue()
					,	pindah_alasan				: this.form_pindah_alasan.getValue()
					,	kd_tingkat_kelas			: this.form_tingkat_kelas.getValue()
					,	diterima_tanggal			: this.form_diterima_tanggal.getValue()
					,	dml_type					: this.dml_type
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

						m_adm_siswa_pembentukan_data_awal_siswa_pindahan_list.do_load();
						m_adm_siswa_pembentukan_data_awal_siswa_pindahan.panel.layout.setActiveItem(0);
					}
			,	scope	: this
		});
	}

	this.do_refresh = function()
	{
		this.store_agama.load();
		this.store_gol_darah.load();
		this.store_asal_smp.load();
		this.store_tingkat_kelas.load();
	}
}

function M_AdmSiswaPembentukanDataAwalSiswaPindahanList()
{
	this.dml_type	= 0;
	this.pageSize	= 50;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_siswa' }
		,	{ name	: 'nis' }
		,	{ name	: 'nm_siswa' }
		,	{ name	: 'asal_smp' }
		,	{ name	: 'alamat' }
	]);

	this.store = new Ext.ux.data.PagingArrayStore({
			fields		: this.record
		,	url			: m_adm_siswa_pembentukan_data_awal_siswa_pindahan_d +'data_list.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
	});

	this.store_asal_smp = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pembentukan_data_awal_siswa_pindahan_d +'data_ref_asal_smp.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	/* form items */
	this.form_asal_smp = new Ext.form.ComboBox({
			store			: this.store_asal_smp
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
		,	{ header		: 'Nomor Induk'
			, dataIndex		: 'nis'
			, align			: 'center'
			, width			: 100
			, filterable	: true
			}
		,	{ header		: 'Nama Siswa'
			, dataIndex		: 'nm_siswa'
			, width			: 200
			, filterable	: true
			}
		,	{ header		: 'Asal Sekolah'
			, dataIndex		: 'asal_smp'
			, editor		: this.form_asal_smp
			, renderer		: combo_renderer(this.form_asal_smp)
			, width			: 200
			, filter		: {
					type		: 'list'
				,	store		: this.store_asal_smp
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
						m_adm_siswa_pembentukan_data_awal_siswa_pindahan_id_siswa = data[0].data['id_siswa'];						
					} else {
						m_adm_siswa_pembentukan_data_awal_siswa_pindahan_id_siswa = '';
					}
				}
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
			this.btn_ref
		,	'-'
		,	this.btn_add
		,	'-'
		,	this.btn_edit
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
		,	autoExpandColumn	: 'alamat'
		,	tbar				: this.toolbar
		,	bbar				: new Ext.PagingToolbar({
									store			: this.store
								,	pageSize		: this.pageSize
								,	firstText		: 'Halaman Awal'
								,	prevText		: 'Halaman Sebelumnya'
								,	beforePageText	: 'Halaman'
								,	afterPageText	: 'dari {0}'
								,	nextText		: 'Halaman Selanjutnya'
								,	lastText		: 'Halaman Terakhir'
								,	plugins			: [this.filters]
								})
	});

	this.do_edit = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_adm_siswa_pembentukan_data_awal_siswa_pindahan_detail.do_refresh();
		m_adm_siswa_pembentukan_data_awal_siswa_pindahan_detail.do_edit(data.get('id_siswa'));
		m_adm_siswa_pembentukan_data_awal_siswa_pindahan.panel.layout.setActiveItem(1);
	}

	this.do_add = function()
	{
		m_adm_siswa_pembentukan_data_awal_siswa_pindahan_detail.do_add();
		m_adm_siswa_pembentukan_data_awal_siswa_pindahan_detail.do_refresh();
		m_adm_siswa_pembentukan_data_awal_siswa_pindahan.panel.layout.setActiveItem(1);
	}
	
	this.do_load = function()
	{
		delete this.store.lastParams;
		
		this.store_asal_smp.load({
			callback	: function(){
				this.store.load({
					params	: {
						start	: 0
					,	limit	: this.pageSize
					}
				});
			}
		,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_adm_siswa_pembentukan_data_awal_siswa_pindahan_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_siswa_pembentukan_data_awal_siswa_pindahan_ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (m_adm_siswa_pembentukan_data_awal_siswa_pindahan_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		this.do_load();
	}
}

function M_AdmSiswaPembentukanDataAwalSiswaPindahan(title)
{
	m_adm_siswa_pembentukan_data_awal_siswa_pindahan_list	= new M_AdmSiswaPembentukanDataAwalSiswaPindahanList();
	m_adm_siswa_pembentukan_data_awal_siswa_pindahan_detail	= new M_AdmSiswaPembentukanDataAwalSiswaPindahanDetail();
	
	this.panel = new Ext.Panel({
			id				: 'adm_siswa_pembentukan_data_awal_siswa_pindahan_panel'
		,	title			: title
		,	layout			: 'card'
		,	activeItem		: 0
		,	autoWidth		: true
		,	autoScroll		: true
		,	items			: [
				m_adm_siswa_pembentukan_data_awal_siswa_pindahan_list.panel
			,	m_adm_siswa_pembentukan_data_awal_siswa_pindahan_detail.panel
			]
	});
	
	this.do_refresh = function(ha_level)
	{
		m_adm_siswa_pembentukan_data_awal_siswa_pindahan_ha_level = ha_level;
		
		m_adm_siswa_pembentukan_data_awal_siswa_pindahan_list.do_refresh();
	}
}

m_adm_siswa_pembentukan_data_awal_siswa_pindahan = new M_AdmSiswaPembentukanDataAwalSiswaPindahan('Pembentukan Data Awal Siswa Pindahan');

//@ sourceURL=adm_siswa_pembentukan_data_awal_siswa_pindahan.layout.js
