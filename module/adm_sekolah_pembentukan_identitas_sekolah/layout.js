/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_sekolah_pembentukan_identitas_sekolah;
var m_adm_sekolah_pembentukan_identitas_sekolah_d = _g_root +'/module/adm_sekolah_pembentukan_identitas_sekolah/';
var m_adm_sekolah_pembentukan_identitas_sekolah_ha_level = 0;

function M_AdmSekolahPembentukanIdentitasSekolah(title)
{
	this.title			= title;
	this.dml_type		= 0;
	this.nss			= '';
	this.id_propinsi	= 0;
	this.id_kabupaten	= 0;

	/* store */
	this.store_bentuk_sekolah = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: m_adm_sekolah_pembentukan_identitas_sekolah_d + 'data_ref_bentuk_sekolah.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
		,	listeners	: {
					scope	: this
				,	load	: function(store, records, options) {
						this.store_jenis_sekolah.load();
					}
			}
	});

	this.store_jenis_sekolah = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: m_adm_sekolah_pembentukan_identitas_sekolah_d + 'data_ref_jenis_sekolah.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
		,	listeners	: {
					scope	: this
				,	load	: function(store, records, options) {
						this.store_waktu_penyelenggaraan.load();
					}
			}
	});

	this.store_status_sekolah = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	data		: [['1', 'Negeri'],['2', 'Swasta']]
	});

	this.store_waktu_penyelenggaraan = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: m_adm_sekolah_pembentukan_identitas_sekolah_d + 'data_ref_waktu_penyelenggaraan.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
		,	listeners	: {
					scope	: this
				,	load	: function(store, records, options) {
						this.store_klasifikasi_geografis.load();
					}
			}
	});

	this.store_daerah = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	data		: [['1', 'Desa'],['2', 'Kelurahan']]
	});

	this.store_klasifikasi_geografis = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: m_adm_sekolah_pembentukan_identitas_sekolah_d + 'data_ref_klasifikasi_geografis.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
		,	listeners	: {
					scope	: this
				,	load	: function(store, records, options) {
						this.store_propinsi.load();
					}
			}
	});

	this.store_propinsi = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: m_adm_sekolah_pembentukan_identitas_sekolah_d + 'data_ref_propinsi.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
		,	listeners	: {
					scope	: this
				,	load	: function(store, records, options) {
						this.store_kabupaten.load();
					}
			}
	});

	this.store_kabupaten = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: m_adm_sekolah_pembentukan_identitas_sekolah_d + 'data_ref_kabupaten.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
		,	listeners	: {
					scope	: this
				,	load	: function(store, records, options) {
						this.store_kecamatan.load({
							params	: {
									id_propinsi		: this.id_propinsi
								,	id_kabupaten	: this.id_kabupaten
							}
						});
					}
			}
	});

	this.store_kecamatan = new Ext.data.ArrayStore({
			fields		: ['id_pro', 'id_kab', 'id', 'name']
		,	url			: m_adm_sekolah_pembentukan_identitas_sekolah_d + 'data_ref_kecamatan.jsp'
		,	autoLoad	: false
		,	idIndex		: 2
		,	listeners	: {
					scope	: this
				,	load	: function(store, records, options) {
						this.store_klasifikasi_sekolah.load();
					}
			}
	});

	this.store_klasifikasi_sekolah = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: m_adm_sekolah_pembentukan_identitas_sekolah_d + 'data_ref_klasifikasi_sekolah.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
		,	listeners	: {
					scope	: this
				,	load	: function(store, records, options) {
						this.do_load();
					}
			}
	});

	this.store_kategori = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	data		: [['1', 'SMP Satu Atap'],['2', 'Biasa']]
	});

	/* form items */
	this.form_npsn = new Ext.form.NumberField({
			fieldLabel		: 'NPSN'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 8
		,	maxLengthText	: 'Maksimal panjang kolom NPSN adalah 8'
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_nm_sekolah = new Ext.form.TextField({
			fieldLabel		: 'Nama Sekolah'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});
	
	this.form_bentuk_sekolah = new Ext.form.ComboBox({
			fieldLabel		: 'Bentuk Sekolah'
		,	store			: this.store_bentuk_sekolah
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

	this.form_jenis_sekolah = new Ext.form.ComboBox({
			fieldLabel		: 'Jenis Sekolah'
		,	store			: this.store_jenis_sekolah
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

	this.form_status_sekolah = new Ext.form.ComboBox({
			fieldLabel		: 'Status Sekolah'
		,	store			: this.store_status_sekolah
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

	this.form_waktu_penyelenggaraan = new Ext.form.ComboBox({
			fieldLabel		: 'Waktu Penyelenggaraan'
		,	store			: this.store_waktu_penyelenggaraan
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
	
	this.form_jalan = new Ext.form.TextArea({
			fieldLabel		: 'Jalan'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_kd_desa = new Ext.form.TextField({
			fieldLabel		: 'Desa / Kelurahan'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_daerah = new Ext.form.ComboBox({
			fieldLabel		: 'Daerah'
		,	store			: this.store_daerah
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

	this.form_klasifikasi_geografis = new Ext.form.ComboBox({
			fieldLabel		: 'Klasifikasi Geografis'
		,	store			: this.store_klasifikasi_geografis
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

	this.form_propinsi = new Ext.form.ComboBox({
			fieldLabel		: 'Propinsi'
		,	store			: this.store_propinsi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	disabled		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_kabupaten = new Ext.form.ComboBox({
			fieldLabel		: 'Kabupaten / Kota'
		,	store			: this.store_kabupaten
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	disabled		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_kecamatan = new Ext.form.ComboBox({
			fieldLabel		: 'Kecamatan'
		,	store			: this.store_kecamatan
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_kd_pos = new Ext.form.NumberField({
			fieldLabel		: 'Kode Pos'
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 5
		,	maxLengthText	: 'Maksimal panjang kolom Kode Pos adalah 5'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_kd_area = new Ext.form.TextField({
			fieldLabel		: 'Kode Area'
		,	hideLabel		: true
		,	maxLength		: 5
		,	maxLengthText	: 'Maksimal panjang kolom Kode Area adalah 5'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_no_telp = new Ext.form.NumberField({
			fieldLabel		: 'No.Telepon'
		,	hideLabel		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 30
		,	maxLengthText	: 'Maksimal panjang kolom No.Telepon adalah 30'
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_no_fax = new Ext.form.NumberField({
			fieldLabel		: 'No.Fax'
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 30
		,	maxLengthText	: 'Maksimal panjang kolom No.Fax adalah 30'
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_jarak_skl_sjns = new Ext.form.NumberField({
			fieldLabel		: 'Jarak Sekolah Sejenis Terdekat'
		,	hideLabel		: true
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_klasifikasi_sekolah = new Ext.form.ComboBox({
			fieldLabel		: 'Klasifikasi Sekolah'
		,	store			: this.store_klasifikasi_sekolah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_kategori = new Ext.form.ComboBox({
			fieldLabel		: 'Kategori Sekolah (Khusus SMP)'
		,	store			: this.store_kategori
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 100
		,	msgTarget		: 'side'
	});

	/* form */
	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 200
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_npsn
				,	this.form_nm_sekolah
				,	this.form_bentuk_sekolah
				,	this.form_jenis_sekolah
				,	this.form_status_sekolah
				,	this.form_waktu_penyelenggaraan
				,	{
						xtype		: 'fieldset'
					,	title		: 'Alamat'
					,	collapsible	: true
					,	items		: [
								this.form_jalan
							,	this.form_kd_desa
							,	this.form_daerah
							,	this.form_klasifikasi_geografis
							,	this.form_propinsi
							,	this.form_kabupaten
							,	this.form_kecamatan
							,	this.form_kd_pos
							,	{
									xtype	: 'compositefield'
								,	title	: 'Kode Area - No.Telepon'
								,	items	: [
											this.form_kd_area
										,	{
												xtype	: 'displayfield'
											,	value	: '-'
											}
										,	this.form_no_telp
									]
								}
							,	this.form_no_fax
							,	{
									xtype	: 'compositefield'
								,	title	: 'Jarak Sekolah Sejenis Terdekat'
								,	items	: [
											this.form_jarak_skl_sjns
										,	{
												xtype	: 'displayfield'
											,	value	: '(KM)'
											}
									]									
								}
						]
					}
				,	this.form_klasifikasi_sekolah
				,	this.form_kategori
			]
	});

	/* button */
	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
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

	/* panel */
	this.panel = new Ext.Panel({
			title		: this.title
		,	autoWidth	: true
		,	autoScroll	: true
		,	padding		:'6'
		,	tbar		: [
				this.btn_ref
			,	'->'
			,	this.btn_save
			]
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

	/* function */
	this.edit_fill_form = function(data)
	{
		this.form_npsn.setValue(data.npsn);
		this.form_nm_sekolah.setValue(data.nm_sekolah);
		this.form_bentuk_sekolah.setValue(data.kd_bentuk_sekolah);
		this.form_jenis_sekolah.setValue(data.kd_jenis_sekolah);
		this.form_status_sekolah.setValue(data.kd_status_sekolah);
		this.form_waktu_penyelenggaraan.setValue(data.kd_waktu_penyelenggaraan);
		this.form_jalan.setValue(data.jalan);
		this.form_kd_desa.setValue(data.kd_desa);
		this.form_daerah.setValue(data.kd_daerah);
		this.form_klasifikasi_geografis.setValue(data.kd_klasifikasi_geografis);
		this.form_propinsi.setValue(this.id_propinsi);
		this.form_kabupaten.setValue(this.id_kabupaten);
		this.form_kecamatan.setValue(data.id_kecamatan);
		this.form_kd_pos.setValue(data.kd_pos);
		this.form_kd_area.setValue(data.kd_area);
		this.form_no_telp.setValue(data.no_telp);
		this.form_jarak_skl_sjns.setValue(data.jarak_skl_sjns);
		this.form_klasifikasi_sekolah.setValue(data.kd_klasifikasi_sekolah);
		this.form_kategori.setValue(data.kategori);
		
		if(this.form_npsn.getValue() == ''){
			this.dml_type	= 2;
		} else {
			this.dml_type	= 3;
		}
	}
	
	this.is_valid = function()
	{
		if (!this.form_npsn.isValid()) {
			return false;
		}

		if (!this.form_nm_sekolah.isValid()) {
			return false;
		}

		if (!this.form_bentuk_sekolah.isValid()) {
			return false;
		}

		if (!this.form_jenis_sekolah.isValid()) {
			return false;
		}

		if (!this.form_status_sekolah.isValid()) {
			return false;
		}

		if (!this.form_waktu_penyelenggaraan.isValid()) {
			return false;
		}

		if (!this.form_jalan.isValid()) {
			return false;
		}

		if (!this.form_kd_desa.isValid()) {
			return false;
		}

		if (!this.form_daerah.isValid()) {
			return false;
		}

		if (!this.form_klasifikasi_geografis.isValid()) {
			return false;
		}

		if (!this.form_kecamatan.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (m_adm_sekolah_pembentukan_identitas_sekolah_ha_level < 2) {
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				params  : {
						npsn						: this.form_npsn.getValue()
					,	nm_sekolah					: this.form_nm_sekolah.getValue()
					,	kd_bentuk_sekolah			: this.form_bentuk_sekolah.getValue()
					,	kd_jenis_sekolah			: this.form_jenis_sekolah.getValue()
					,	kd_status_sekolah			: this.form_status_sekolah.getValue()
					,	kd_waktu_penyelenggaraan	: this.form_waktu_penyelenggaraan.getValue()
					,	jalan						: this.form_jalan.getValue()
					,	kd_desa						: this.form_kd_desa.getValue()
					,	kd_daerah					: this.form_daerah.getValue()
					,	kd_klasifikasi_geografis	: this.form_klasifikasi_geografis.getValue()
					,	id_propinsi					: this.form_propinsi.getValue()
					,	id_kabupaten				: this.form_kabupaten.getValue()
					,	id_kecamatan				: this.form_kecamatan.getValue()
					,	kd_pos						: this.form_kd_pos.getValue()
					,	kd_area						: this.form_kd_area.getValue()
					,	no_telp						: this.form_no_telp.getValue()
					,	no_fax						: this.form_no_fax.getValue()
					,	jarak_skl_sjns				: this.form_jarak_skl_sjns.getValue()
					,	kd_klasifikasi_sekolah		: this.form_klasifikasi_sekolah.getValue()
					,	kategori					: this.form_kategori.getValue()
					,	dml_type					: this.dml_type
				}
			,	url		: m_adm_sekolah_pembentukan_identitas_sekolah_d +'submit.jsp'
			,	waitMsg	: 'Mohon Tunggu ...'
			,	failure	: function(response) {
					Ext.MessageBox.alert('Gagal', response.responseText);
				}
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						Ext.MessageBox.alert('Informasi', msg.info);
						
						this.do_load();
					}
			,	scope	: this
		});
	}
	
	this.do_load = function()
	{
		Ext.Ajax.request({
			url		: m_adm_sekolah_pembentukan_identitas_sekolah_d +'data.jsp'
		,	waitMsg	: 'Pemuatan ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				this.edit_fill_form(msg);
				
				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
					return;
				}
			}
		,	scope	: this		
		});
	}

	this.do_refresh = function(ha_level)
	{
		m_adm_sekolah_pembentukan_identitas_sekolah_ha_level = ha_level;
		
		if (m_adm_sekolah_pembentukan_identitas_sekolah_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_sekolah_pembentukan_identitas_sekolah_ha_level >= 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}
	
		Ext.Ajax.request({
			url		: m_adm_sekolah_pembentukan_identitas_sekolah_d +'data_wilayah.jsp'
		,	waitMsg	: 'Pemuatan ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
					return;
				}

				this.id_propinsi	= msg.id_propinsi;
				this.id_kabupaten	= msg.id_kabupaten;
			}
		,	scope	: this		
		});		
	
		this.store_bentuk_sekolah.load();
	}
}

m_adm_sekolah_pembentukan_identitas_sekolah = new M_AdmSekolahPembentukanIdentitasSekolah('Pembentukan Identitas Sekolah');

//@ sourceURL=adm_sekolah_pembentukan_identitas_sekolah.layout.js
