/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_siswa_pemeliharaan_data_induk_siswa;
var m_adm_siswa_pemeliharaan_data_induk_siswa_master;
var m_adm_siswa_pemeliharaan_data_induk_siswa_detail_info_siswa;
var m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_ayah;
var m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_ibu;
var m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_wali;
var m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_hobi;
var m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_cuti;
var m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_pindah_sekolah;
var m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_putus_sekolah;
var m_adm_siswa_pemeliharaan_data_induk_siswa_detail_riwayat_sakit;
var m_adm_siswa_pemeliharaan_data_induk_siswa_detail_beasiswa;
var m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa = '';
var m_adm_siswa_pemeliharaan_data_induk_siswa_d = _g_root +'/module/adm_siswa_pemeliharaan_data_induk_siswa/';
var m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level = 0;

function m_adm_siswa_pemeliharaan_data_induk_siswa_master_on_select_load_detail()
{
 	if (typeof m_adm_siswa_pemeliharaan_data_induk_siswa_master == 'undefined'
	||  typeof m_adm_siswa_pemeliharaan_data_induk_siswa_detail_info_siswa == 'undefined'
	||  typeof m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_ibu == 'undefined'
	||  typeof m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_wali == 'undefined'
	||  typeof m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_hobi == 'undefined'
	||  typeof m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_cuti == 'undefined'
	||  typeof m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_pindah_sekolah == 'undefined'
	||  typeof m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_putus_sekolah == 'undefined'
	||  typeof m_adm_siswa_pemeliharaan_data_induk_siswa_detail_riwayat_sakit == 'undefined'
	||  typeof m_adm_siswa_pemeliharaan_data_induk_siswa_detail_beasiswa == 'undefined'
	||	m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
		return;
	}

	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_info_siswa.do_refresh();
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_ayah.do_refresh();
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_ibu.do_refresh();
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_wali.do_refresh();
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_hobi.do_refresh();
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_cuti.do_refresh();
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_pindah_sekolah.do_refresh();
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_putus_sekolah.do_refresh();
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_riwayat_sakit.do_refresh();
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_beasiswa.do_refresh();
}

function M_AdmSiswaPemeliharaanDataIndukSiswaDetailInfoSiswa(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* store */
	this.store_hubungi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['1', 'Ayah']
			,	['2', 'Ibu']
			,	['3', 'Wali']
			]
		,	idIndex		: 0
	});

	this.store_tanggung_biaya = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				[1, 'Ayah']
			,	[2, 'Ibu']
			,	[3, 'Wali']
			,	[4, 'Sendiri']
			]
		,	idIndex		: 0
	});
	
	this.store_status_yatim_piatu = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['0', 'Orangtua Lengkap']
			,	['1', 'Yatim']
			,	['2', 'Piatu']
			,	['3', 'Yatim Piatu']
			]
		,	idIndex		: 0
	});

	this.store_kesejahteraan_keluarga = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_ref_kesejahteraan_keluarga.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});
	
	this.store_ketunaan = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_ref_ketunaan.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});
	
	/* form items */
	this.form_hubungi = new Ext.form.ComboBox({
			fieldLabel		: 'Pihak yang dihubungi'
		,	store			: this.store_hubungi
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

	this.form_tanggung_biaya = new Ext.form.ComboBox({
			fieldLabel		: 'Penanggung Biaya'
		,	store			: this.store_tanggung_biaya
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

	this.form_status_yatim_piatu = new Ext.form.ComboBox({
			fieldLabel		: 'Status Yatim Piatu'
		,	store			: this.store_status_yatim_piatu
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

	this.form_kesejahteraan_keluarga = new Ext.form.ComboBox({
			fieldLabel		: 'Kesejahteraan Keluarga'
		,	store			: this.store_kesejahteraan_keluarga
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

	this.form_anak_ke = new Ext.form.NumberField({
			fieldLabel		: 'Anak Ke'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 2
		,	maxLengthText	: 'Maksimal panjang kolom adalah 2'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_jumlah_kandung = new Ext.form.NumberField({
			fieldLabel		: 'Jumlah Saudara Kandung'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 2
		,	maxLengthText	: 'Maksimal panjang kolom adalah 2'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_jumlah_tiri = new Ext.form.NumberField({
			fieldLabel		: 'Jumlah Saudara Tiri'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 2
		,	maxLengthText	: 'Maksimal panjang kolom adalah 2'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_jumlah_angkat = new Ext.form.NumberField({
			fieldLabel		: 'Jumlah Saudara Angkat'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 2
		,	maxLengthText	: 'Maksimal panjang kolom adalah 2'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_kewarganegaraan = new Ext.form.TextField({
			fieldLabel		: 'Kewarganegaraan'
		,	allowBlank		: false
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_bahasa = new Ext.form.TextField({
			fieldLabel		: 'Bahasa Sehari-hari'
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_tinggal_di = new Ext.form.TextField({
			fieldLabel		: 'Tinggal Di'
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_jarak_sek = new Ext.form.NumberField({
			fieldLabel		: 'Jarak Sekolah'
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_ketunaan = new Ext.form.ComboBox({
			fieldLabel		: 'Status Ketunaan'
		,	store			: this.store_ketunaan
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

	this.form_kelainan_jasmani = new Ext.form.TextArea({
			fieldLabel		: 'Kelainan Jasmani'
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_berat_badan = new Ext.form.NumberField({
			fieldLabel		: 'Berat Badan'
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_tinggi_badan = new Ext.form.NumberField({
			fieldLabel		: 'Tinggi Badan'
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_no_stl_sd = new Ext.form.TextField({
			fieldLabel		: 'No STL SD'
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_tanggal_stl_sd = new Ext.form.DateField({
			fieldLabel	: 'Tanggal STL SD'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	editable	: true
		,	width		: 150
		,	msgTarget	: 'side'
	});
	
	this.form_lama_belajar_sd = new Ext.form.NumberField({
			fieldLabel		: 'Lama Belajar di SD'
		,	allowDecimals	: false
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	/* form */
	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 175
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_hubungi
				,	this.form_tanggung_biaya
				,	this.form_status_yatim_piatu
				,	this.form_kesejahteraan_keluarga
				,	this.form_anak_ke
				,	this.form_jumlah_kandung
				,	this.form_jumlah_tiri
				,	this.form_jumlah_angkat
				,	this.form_kewarganegaraan
				,	this.form_bahasa
				,	this.form_tinggal_di
				,	{
						xtype		: 'compositefield'
					,	fieldLabel	: 'Jarak Sekolah'
					,	items		: [
								this.form_jarak_sek
							,	{
									xtype	: 'displayfield'
								,	value	: 'km'
								}
						]
					}
				,	this.form_ketunaan
				,	this.form_kelainan_jasmani
				,	{
						xtype		: 'compositefield'
					,	fieldLabel	: 'Tinggi / Berat Badan'
					,	items		: [
								this.form_tinggi_badan
							,	{
									xtype	: 'displayfield'
								,	value	: 'cm'
								}
							,	{
									xtype	: 'displayfield'
								,	value	: '/'
								}
							,	this.form_berat_badan
							,	{
									xtype	: 'displayfield'
								,	value	: 'kg'
								}
						]
					}
				,	{
						xtype		: 'compositefield'
					,	fieldLabel	: 'No.STL / Tanggal'
					,	items		: [
								this.form_no_stl_sd
							,	{
									xtype	: 'displayfield'
								,	value	: '/'
								}
							,	this.form_tanggal_stl_sd
						]
					}
				,	{
						xtype		: 'compositefield'
					,	fieldLabel	: 'Lama Belajar di SD'
					,	items		: [
								this.form_lama_belajar_sd
							,	{
									xtype	: 'displayfield'
								,	value	: 'tahun'
								}
						]
					}
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
	this.do_reset = function()
	{
		this.form_hubungi.setValue('');
		this.form_tanggung_biaya.setValue('');
		this.form_status_yatim_piatu.setValue('');
		this.form_kesejahteraan_keluarga.setValue('');
		this.form_anak_ke.setValue('');
		this.form_jumlah_kandung.setValue('');
		this.form_jumlah_tiri.setValue('');
		this.form_jumlah_angkat.setValue('');
		this.form_kewarganegaraan.setValue('');
		this.form_bahasa.setValue('');
		this.form_tinggal_di.setValue('');
		this.form_jarak_sek.setValue('');
		this.form_ketunaan.setValue('');
		this.form_kelainan_jasmani.setValue('');
		this.form_berat_badan.setValue('');
		this.form_tinggi_badan.setValue('');		
		this.form_no_stl_sd.setValue('');		
		this.form_tanggal_stl_sd.setValue('');		
		this.form_lama_belajar_sd.setValue('');	
	}
	
	this.edit_fill_form = function(data)
	{
		this.do_reset();

		this.form_hubungi.setValue(data.hubungi);
		this.form_tanggung_biaya.setValue(data.tanggung_biaya);
		this.form_status_yatim_piatu.setValue(data.status_yatim_piatu);
		this.form_kesejahteraan_keluarga.setValue(data.kd_kesejahteraan_keluarga);
		this.form_anak_ke.setValue(data.anak_ke);
		this.form_jumlah_kandung.setValue(data.jumlah_kandung);
		this.form_jumlah_tiri.setValue(data.jumlah_tiri);
		this.form_jumlah_angkat.setValue(data.jumlah_angkat);
		this.form_kewarganegaraan.setValue(data.kewarganegaraan);
		this.form_bahasa.setValue(data.bahasa);
		this.form_tinggal_di.setValue(data.tinggal_di);
		this.form_jarak_sek.setValue(data.jarak_sek);
		this.form_ketunaan.setValue(data.kd_ketunaan);
		this.form_kelainan_jasmani.setValue(data.kd_kelainan_jasmani);
		this.form_berat_badan.setValue(data.berat_badan);
		this.form_tinggi_badan.setValue(data.tinggi_badan);		
		this.form_no_stl_sd.setValue(data.no_stl_sd);		
		this.form_tanggal_stl_sd.setValue(data.tanggal_stl_sd);		
		this.form_lama_belajar_sd.setValue(data.lama_belajar_sd);		
	}
	
	this.is_valid = function()
	{
		if (!this.form_hubungi.isValid()) {
			return false;
		}
		
		if (!this.form_tanggung_biaya.isValid()) {
			return false;
		}

		if (!this.form_kesejahteraan_keluarga.isValid()) {
			return false;
		}
		
		if (!this.form_kewarganegaraan.isValid()) {
			return false;
		}

		if (!this.form_ketunaan.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				params  : {
						id_siswa					: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
					,	hubungi						: this.form_hubungi.getValue()
					,	tanggung_biaya				: this.form_tanggung_biaya.getValue()
					,	status_yatim_piatu			: this.form_status_yatim_piatu.getValue()
					,	kd_kesejahteraan_keluarga	: this.form_kesejahteraan_keluarga.getValue()
					,	anak_ke						: this.form_anak_ke.getValue()
					,	jumlah_kandung				: this.form_jumlah_kandung.getValue()
					,	jumlah_tiri					: this.form_jumlah_tiri.getValue()
					,	jumlah_angkat				: this.form_jumlah_angkat.getValue()
					,	kewarganegaraan				: this.form_kewarganegaraan.getValue()
					,	bahasa						: this.form_bahasa.getValue()
					,	tinggal_di					: this.form_tinggal_di.getValue()
					,	jarak_sek					: this.form_jarak_sek.getValue()
					,	kd_ketunaan					: this.form_ketunaan.getValue()
					,	kelainan_jasmani			: this.form_kelainan_jasmani.getValue()
					,	berat_badan					: this.form_berat_badan.getValue()
					,	tinggi_badan				: this.form_tinggi_badan.getValue()
					,	no_stl_sd					: this.form_no_stl_sd.getValue()
					,	tanggal_stl_sd				: this.form_tanggal_stl_sd.getValue()
					,	lama_belajar_sd				: this.form_lama_belajar_sd.getValue()
					,	dml_type					: this.dml_type
				}
			,	url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d + 'submit_detail_info_siswa.jsp'
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
			url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_detail_info_siswa.jsp'
		,	params	: {
				id_siswa	: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
			}
		,	waitMsg	: 'Pemuatan ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);
				
				if (msg.success == false) {
					this.do_reset();
					this.dml_type	= 2;
					return;
				}
				
				this.edit_fill_form(msg);
				this.dml_type	= 3;
			}
		,	scope	: this		
		});
	}

	this.do_refresh = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level >= 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}
	
		this.store_ketunaan.load();
		this.store_kesejahteraan_keluarga.load();
		
		this.do_load();
	}
}

function M_AdmSiswaPemeliharaanDataIndukSiswaDetailDataAyah(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* store */
	this.store_agama = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_ref_agama.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_tingkat_ijazah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_ref_tingkat_ijazah.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_gol_pekerjaan_ortu = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_ref_gol_pekerjaan_ortu.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_status_hub = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['1', 'Kandung']
			,	['2', 'Tiri']
			,	['3', 'Angkat']
			,	['9', 'Lain-Lain']
			]
		,	idIndex		: 0
	});

	this.store_status_nikah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['N', 'Menikah']
			,	['D', 'Duda']
			,	['B', 'Belum Menikah']
			]
		,	idIndex		: 0
	});

	this.store_status_hidup = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['1', 'Ya']
			,	['2', 'Tidak']
			]
		,	idIndex		: 0
	});
	
	/* form items */
	this.form_nm_ortu = new Ext.form.TextField({
			fieldLabel		: 'Nama Ayah'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_kota_lahir = new Ext.form.TextField({
			fieldLabel		: 'Kota Lahir'
		,	allowBlank		: false
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_tanggal_lahir = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Lahir'
		,	emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	invalidText		: 'Kolom ini harus berformat tanggal'
		,	allowBlank		: false
		,	editable		: true
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

	this.form_kewarganegaraan = new Ext.form.TextField({
			fieldLabel		: 'Kewarganegaraan'
		,	allowBlank		: true
		,	width			: 200
		,	msgTarget		: 'side'
	});
	
	this.form_tingkat_ijazah = new Ext.form.ComboBox({
			fieldLabel		: 'Pendidikan Terakhir'
		,	store			: this.store_tingkat_ijazah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 250
		,	msgTarget		: 'side'
	});
	
	this.form_gol_pekerjaan_ortu = new Ext.form.ComboBox({
			fieldLabel		: 'Pekerjaan'
		,	store			: this.store_gol_pekerjaan_ortu
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 250
		,	msgTarget		: 'side'
	});

	this.form_gaji = new Ext.ux.NumericField({
			fieldLabel				: 'Penghasilan per Bulan'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 200
		,	msgTarget				: 'side'
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

	this.form_kd_pos = new Ext.form.NumberField({
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
	
	this.form_status_hub = new Ext.form.ComboBox({
			fieldLabel		: 'Status Ayah'
		,	store			: this.store_status_hub
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

	this.form_status_hidup = new Ext.form.ComboBox({
			fieldLabel		: 'Masih Hidup'
		,	store			: this.store_status_hidup
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
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					if (newvalue == '2'){
						this.form_tahun_meninggal.show();
					} else {
						this.form_tahun_meninggal.hide();
						this.form_tahun_meninggal.setValue('');
					}
				}
			,	scope	: this
			}
	});

	this.form_tahun_meninggal = new Ext.form.NumberField({
			fieldLabel		: 'Tahun Meninggal'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	hidden			: true
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom adalah 4'
		,	width			: 50
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

	/* form */
	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 175
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_nm_ortu
				,	{
						xtype		: 'compositefield'
					,	fieldLabel	: 'Tempat dan Tanggal Lahir'
					,	msgTarget	: 'under'
					,	items		: [
							this.form_kota_lahir
						,	{
								xtype	: 'displayfield'
							,	value	: ','
							}
						,	this.form_tanggal_lahir
						]
					}
				,	this.form_agama
				,	this.form_kewarganegaraan
				,	this.form_tingkat_ijazah
				,	this.form_gol_pekerjaan_ortu
				,	this.form_gaji
				,	this.form_alamat
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
						,	this.form_kd_pos
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
				,	this.form_status_hub
				,	this.form_status_hidup
				,	this.form_tahun_meninggal
				,	this.form_status_nikah
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
	this.do_reset = function()
	{
		this.form_nm_ortu.setValue('');
		this.form_kota_lahir.setValue('');
		this.form_tanggal_lahir.setValue('');
		this.form_agama.setValue('');
		this.form_kewarganegaraan.setValue('');
		this.form_tingkat_ijazah.setValue('');
		this.form_gol_pekerjaan_ortu.setValue('');
		this.form_gaji.setValue('');
		this.form_alamat.setValue('');
		this.form_rt.setValue('');
		this.form_rw.setValue('');
		this.form_kd_pos.setValue('');		
		this.form_no_telp.setValue('');		
		this.form_no_hp.setValue('');		
		this.form_status_hub.setValue('');	
		this.form_status_nikah.setValue('');	
		this.form_status_hidup.setValue('');	
		this.form_tahun_meninggal.setValue('');	
		
		this.form_tahun_meninggal.hide();	
	}
	
	this.edit_fill_form = function(data)
	{
		this.form_nm_ortu.setValue('');
		this.form_kota_lahir.setValue('');
		this.form_tanggal_lahir.setValue('');
		this.form_agama.setValue('');
		this.form_kewarganegaraan.setValue('');
		this.form_tingkat_ijazah.setValue('');
		this.form_gol_pekerjaan_ortu.setValue('');
		this.form_gaji.setValue('');
		this.form_alamat.setValue('');
		this.form_rt.setValue('');
		this.form_rw.setValue('');
		this.form_kd_pos.setValue('');		
		this.form_no_telp.setValue('');		
		this.form_no_hp.setValue('');		
		this.form_status_hub.setValue('');	
		this.form_status_nikah.setValue('');	
		this.form_status_hidup.setValue('');	
		this.form_tahun_meninggal.setValue('');		

		this.form_tahun_meninggal.hide();	
		
		this.form_nm_ortu.setValue(data.nm_ortu);
		this.form_kota_lahir.setValue(data.kota_lahir);
		this.form_tanggal_lahir.setValue(data.tanggal_lahir);
		this.form_agama.setValue(data.kd_agama);
		this.form_kewarganegaraan.setValue(data.kewarganegaraan);
		this.form_tingkat_ijazah.setValue(data.kd_tingkat_ijazah);
		this.form_gol_pekerjaan_ortu.setValue(data.id_gol_pekerjaan_ortu);
		this.form_gaji.setValue(data.gaji);
		this.form_alamat.setValue(data.alamat);
		this.form_rt.setValue(data.rt);
		this.form_rw.setValue(data.rw);
		this.form_kd_pos.setValue(data.kd_pos);		
		this.form_no_telp.setValue(data.no_telp);		
		this.form_no_hp.setValue(data.no_hp);		
		this.form_status_hub.setValue(data.status_hub);		
		this.form_status_nikah.setValue(data.kd_status_nikah);		
		this.form_status_hidup.setValue(data.status_hidup);		
		this.form_tahun_meninggal.setValue(data.tahun_meninggal);
		
		if (this.form_status_nikah.getValue() == '2'){
			this.form_tahun_meninggal.show();
		} else {
			this.form_tahun_meninggal.hide();
		}
	}
	
	this.is_valid = function()
	{
		if (!this.form_nm_ortu.isValid()) {
			return false;
		}

		if (!this.form_kota_lahir.isValid()) {
			return false;
		}

		if (!this.form_tanggal_lahir.isValid()) {
			return false;
		}

		if (!this.form_agama.isValid()) {
			return false;
		}

		if (!this.form_tingkat_ijazah.isValid()) {
			return false;
		}

		if (!this.form_gol_pekerjaan_ortu.isValid()) {
			return false;
		}

		if (!this.form_gaji.isValid()) {
			return false;
		}

		if (!this.form_alamat.isValid()) {
			return false;
		}

		if (!this.form_status_hub.isValid()) {
			return false;
		}

		if (!this.form_status_nikah.isValid()) {
			return false;
		}

		if (!this.form_status_hidup.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				params  : {
						id_siswa				: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
					,	nm_ortu					: this.form_nm_ortu.getValue()
					,	kota_lahir				: this.form_kota_lahir.getValue()
					,	tanggal_lahir			: this.form_tanggal_lahir.getValue()
					,	kd_agama				: this.form_agama.getValue()
					,	kewarganegaraan			: this.form_kewarganegaraan.getValue()
					,	kd_tingkat_ijazah		: this.form_tingkat_ijazah.getValue()
					,	id_gol_pekerjaan_ortu	: this.form_gol_pekerjaan_ortu.getValue()
					,	gaji					: this.form_gaji.getValue()
					,	alamat					: this.form_alamat.getValue()
					,	rt						: this.form_rt.getValue()
					,	rw						: this.form_rw.getValue()
					,	kd_pos					: this.form_kd_pos.getValue()
					,	no_telp					: this.form_no_telp.getValue()
					,	no_hp					: this.form_no_hp.getValue()
					,	status_hub				: this.form_status_hub.getValue()
					,	kd_status_nikah			: this.form_status_nikah.getValue()
					,	status_hidup			: this.form_status_hidup.getValue()
					,	tahun_meninggal			: this.form_tahun_meninggal.getValue()
					,	dml_type				: this.dml_type
				}
			,	url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d + 'submit_detail_data_ayah.jsp'
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
			url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_detail_data_ayah.jsp'
		,	params	: {
				id_siswa	: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
			}
		,	waitMsg	: 'Pemuatan ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);
				
				if (msg.success == false) {
					this.do_reset();
					this.dml_type	= 2;
					return;
				}
				
				this.edit_fill_form(msg);
				this.dml_type	= 3;
			}
		,	scope	: this		
		});
	}

	this.do_refresh = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level >= 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}
	
		this.store_agama.load();
		this.store_tingkat_ijazah.load();
		this.store_gol_pekerjaan_ortu.load();
		
		this.do_load();
	}
}

function M_AdmSiswaPemeliharaanDataIndukSiswaDetailDataIbu(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* store */
	this.store_agama = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_ref_agama.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_tingkat_ijazah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_ref_tingkat_ijazah.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_gol_pekerjaan_ortu = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_ref_gol_pekerjaan_ortu.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_status_hub = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['1', 'Kandung']
			,	['2', 'Tiri']
			,	['3', 'Angkat']
			,	['9', 'Lain-Lain']
			]
		,	idIndex		: 0
	});

	this.store_status_nikah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['N', 'Menikah']
			,	['J', 'Janda']
			,	['B', 'Belum Menikah']
			]
		,	idIndex		: 0
	});

	this.store_status_hidup = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['1', 'Ya']
			,	['2', 'Tidak']
			]
		,	idIndex		: 0
	});
	
	/* form items */
	this.form_nm_ortu = new Ext.form.TextField({
			fieldLabel		: 'Nama Ibu'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_kota_lahir = new Ext.form.TextField({
			fieldLabel		: 'Kota Lahir'
		,	allowBlank		: false
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_tanggal_lahir = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Lahir'
		,	emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	invalidText		: 'Kolom ini harus berformat tanggal'
		,	allowBlank		: false
		,	editable		: true
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

	this.form_kewarganegaraan = new Ext.form.TextField({
			fieldLabel		: 'Kewarganegaraan'
		,	allowBlank		: true
		,	width			: 200
		,	msgTarget		: 'side'
	});
	
	this.form_tingkat_ijazah = new Ext.form.ComboBox({
			fieldLabel		: 'Pendidikan Terakhir'
		,	store			: this.store_tingkat_ijazah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 250
		,	msgTarget		: 'side'
	});
	
	this.form_gol_pekerjaan_ortu = new Ext.form.ComboBox({
			fieldLabel		: 'Pekerjaan'
		,	store			: this.store_gol_pekerjaan_ortu
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 250
		,	msgTarget		: 'side'
	});

	this.form_gaji = new Ext.ux.NumericField({
			fieldLabel				: 'Penghasilan per Bulan'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 200
		,	msgTarget				: 'side'
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

	this.form_kd_pos = new Ext.form.NumberField({
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
	
	this.form_status_hub = new Ext.form.ComboBox({
			fieldLabel		: 'Status Ibu'
		,	store			: this.store_status_hub
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

	this.form_status_hidup = new Ext.form.ComboBox({
			fieldLabel		: 'Masih Hidup'
		,	store			: this.store_status_hidup
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
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					if (newvalue == '2'){
						this.form_tahun_meninggal.show();
					} else {
						this.form_tahun_meninggal.hide();
						this.form_tahun_meninggal.setValue('');
					}
				}
			,	scope	: this
			}
	});

	this.form_tahun_meninggal = new Ext.form.NumberField({
			fieldLabel		: 'Tahun Meninggal'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	hidden			: true
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom adalah 4'
		,	width			: 50
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

	/* form */
	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 175
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_nm_ortu
				,	{
						xtype		: 'compositefield'
					,	fieldLabel	: 'Tempat dan Tanggal Lahir'
					,	msgTarget	: 'under'
					,	items		: [
							this.form_kota_lahir
						,	{
								xtype	: 'displayfield'
							,	value	: ','
							}
						,	this.form_tanggal_lahir
						]
					}
				,	this.form_agama
				,	this.form_kewarganegaraan
				,	this.form_tingkat_ijazah
				,	this.form_gol_pekerjaan_ortu
				,	this.form_gaji
				,	this.form_alamat
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
						,	this.form_kd_pos
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
				,	this.form_status_hub
				,	this.form_status_hidup
				,	this.form_tahun_meninggal
				,	this.form_status_nikah
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
	this.do_reset = function()
	{
		this.form_nm_ortu.setValue('');
		this.form_kota_lahir.setValue('');
		this.form_tanggal_lahir.setValue('');
		this.form_agama.setValue('');
		this.form_kewarganegaraan.setValue('');
		this.form_tingkat_ijazah.setValue('');
		this.form_gol_pekerjaan_ortu.setValue('');
		this.form_gaji.setValue('');
		this.form_alamat.setValue('');
		this.form_rt.setValue('');
		this.form_rw.setValue('');
		this.form_kd_pos.setValue('');		
		this.form_no_telp.setValue('');		
		this.form_no_hp.setValue('');		
		this.form_status_hub.setValue('');	
		this.form_status_nikah.setValue('');	
		this.form_status_hidup.setValue('');	
		this.form_tahun_meninggal.setValue('');	
		
		this.form_tahun_meninggal.hide();	
	}
	
	this.edit_fill_form = function(data)
	{
		this.form_nm_ortu.setValue('');
		this.form_kota_lahir.setValue('');
		this.form_tanggal_lahir.setValue('');
		this.form_agama.setValue('');
		this.form_kewarganegaraan.setValue('');
		this.form_tingkat_ijazah.setValue('');
		this.form_gol_pekerjaan_ortu.setValue('');
		this.form_gaji.setValue('');
		this.form_alamat.setValue('');
		this.form_rt.setValue('');
		this.form_rw.setValue('');
		this.form_kd_pos.setValue('');		
		this.form_no_telp.setValue('');		
		this.form_no_hp.setValue('');		
		this.form_status_hub.setValue('');	
		this.form_status_nikah.setValue('');	
		this.form_status_hidup.setValue('');	
		this.form_tahun_meninggal.setValue('');		

		this.form_tahun_meninggal.hide();	
		
		this.form_nm_ortu.setValue(data.nm_ortu);
		this.form_kota_lahir.setValue(data.kota_lahir);
		this.form_tanggal_lahir.setValue(data.tanggal_lahir);
		this.form_agama.setValue(data.kd_agama);
		this.form_kewarganegaraan.setValue(data.kewarganegaraan);
		this.form_tingkat_ijazah.setValue(data.kd_tingkat_ijazah);
		this.form_gol_pekerjaan_ortu.setValue(data.id_gol_pekerjaan_ortu);
		this.form_gaji.setValue(data.gaji);
		this.form_alamat.setValue(data.alamat);
		this.form_rt.setValue(data.rt);
		this.form_rw.setValue(data.rw);
		this.form_kd_pos.setValue(data.kd_pos);		
		this.form_no_telp.setValue(data.no_telp);		
		this.form_no_hp.setValue(data.no_hp);		
		this.form_status_hub.setValue(data.status_hub);		
		this.form_status_nikah.setValue(data.kd_status_nikah);		
		this.form_status_hidup.setValue(data.status_hidup);		
		this.form_tahun_meninggal.setValue(data.tahun_meninggal);
		
		if (this.form_status_nikah.getValue() == '2'){
			this.form_tahun_meninggal.show();
		} else {
			this.form_tahun_meninggal.hide();
		}
	}
	
	this.is_valid = function()
	{
		if (!this.form_nm_ortu.isValid()) {
			return false;
		}

		if (!this.form_kota_lahir.isValid()) {
			return false;
		}

		if (!this.form_tanggal_lahir.isValid()) {
			return false;
		}

		if (!this.form_agama.isValid()) {
			return false;
		}

		if (!this.form_tingkat_ijazah.isValid()) {
			return false;
		}

		if (!this.form_gol_pekerjaan_ortu.isValid()) {
			return false;
		}

		if (!this.form_gaji.isValid()) {
			return false;
		}

		if (!this.form_alamat.isValid()) {
			return false;
		}

		if (!this.form_status_hub.isValid()) {
			return false;
		}

		if (!this.form_status_nikah.isValid()) {
			return false;
		}

		if (!this.form_status_hidup.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				params  : {
						id_siswa						: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
					,	nm_ortu					: this.form_nm_ortu.getValue()
					,	kota_lahir				: this.form_kota_lahir.getValue()
					,	tanggal_lahir			: this.form_tanggal_lahir.getValue()
					,	kd_agama				: this.form_agama.getValue()
					,	kewarganegaraan			: this.form_kewarganegaraan.getValue()
					,	kd_tingkat_ijazah		: this.form_tingkat_ijazah.getValue()
					,	id_gol_pekerjaan_ortu	: this.form_gol_pekerjaan_ortu.getValue()
					,	gaji					: this.form_gaji.getValue()
					,	alamat					: this.form_alamat.getValue()
					,	rt						: this.form_rt.getValue()
					,	rw						: this.form_rw.getValue()
					,	kd_pos					: this.form_kd_pos.getValue()
					,	no_telp					: this.form_no_telp.getValue()
					,	no_hp					: this.form_no_hp.getValue()
					,	status_hub				: this.form_status_hub.getValue()
					,	kd_status_nikah			: this.form_status_nikah.getValue()
					,	status_hidup			: this.form_status_hidup.getValue()
					,	tahun_meninggal			: this.form_tahun_meninggal.getValue()
					,	dml_type				: this.dml_type
				}
			,	url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d + 'submit_detail_data_ibu.jsp'
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
			url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_detail_data_ibu.jsp'
		,	params	: {
				id_siswa	: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
			}
		,	waitMsg	: 'Pemuatan ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);
				
				if (msg.success == false) {
					this.do_reset();
					this.dml_type	= 2;
					return;
				}
				
				this.edit_fill_form(msg);
				this.dml_type	= 3;
			}
		,	scope	: this		
		});
	}

	this.do_refresh = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level >= 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}
	
		this.store_agama.load();
		this.store_tingkat_ijazah.load();
		this.store_gol_pekerjaan_ortu.load();
		
		this.do_load();
	}
}

function M_AdmSiswaPemeliharaanDataIndukSiswaDetailDataWali(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* store */
	this.store_jenis_kelamin = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['1', 'Laki-Laki']
			,	['2', 'Perempuan']
			]
		,	idIndex		: 0
	});

	this.store_agama = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_ref_agama.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_tingkat_ijazah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_ref_tingkat_ijazah.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_gol_pekerjaan_ortu = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_ref_gol_pekerjaan_ortu.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_status_hub = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['1', 'Kandung']
			,	['2', 'Tiri']
			,	['3', 'Angkat']
			,	['9', 'Lain-Lain']
			]
		,	idIndex		: 0
	});

	this.store_status_nikah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['N', 'Menikah']
			,	['D', 'Duda']
			,	['J', 'Janda']
			,	['B', 'Belum Menikah']
			]
		,	idIndex		: 0
	});

	this.store_status_hidup = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['1', 'Ya']
			,	['2', 'Tidak']
			]
		,	idIndex		: 0
	});
	
	/* form items */
	this.form_nm_ortu = new Ext.form.TextField({
			fieldLabel		: 'Nama Wali'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_kota_lahir = new Ext.form.TextField({
			fieldLabel		: 'Kota Lahir'
		,	allowBlank		: false
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_tanggal_lahir = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Lahir'
		,	emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	invalidText		: 'Kolom ini harus berformat tanggal'
		,	allowBlank		: false
		,	editable		: true
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

	this.form_kewarganegaraan = new Ext.form.TextField({
			fieldLabel		: 'Kewarganegaraan'
		,	allowBlank		: true
		,	width			: 200
		,	msgTarget		: 'side'
	});
	
	this.form_tingkat_ijazah = new Ext.form.ComboBox({
			fieldLabel		: 'Pendidikan Terakhir'
		,	store			: this.store_tingkat_ijazah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 250
		,	msgTarget		: 'side'
	});
	
	this.form_gol_pekerjaan_ortu = new Ext.form.ComboBox({
			fieldLabel		: 'Pekerjaan'
		,	store			: this.store_gol_pekerjaan_ortu
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 250
		,	msgTarget		: 'side'
	});

	this.form_gaji = new Ext.ux.NumericField({
			fieldLabel				: 'Penghasilan per Bulan'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 200
		,	msgTarget				: 'side'
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

	this.form_kd_pos = new Ext.form.NumberField({
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
	
	this.form_status_hub = new Ext.form.ComboBox({
			fieldLabel		: 'Status Wali'
		,	store			: this.store_status_hub
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

	this.form_status_hidup = new Ext.form.ComboBox({
			fieldLabel		: 'Masih Hidup'
		,	store			: this.store_status_hidup
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
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					if (newvalue == '2'){
						this.form_tahun_meninggal.show();
					} else {
						this.form_tahun_meninggal.hide();
						this.form_tahun_meninggal.setValue('');
					}
				}
			,	scope	: this
			}
	});

	this.form_tahun_meninggal = new Ext.form.NumberField({
			fieldLabel		: 'Tahun Meninggal'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	hidden			: true
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom adalah 4'
		,	width			: 50
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

	/* form */
	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 175
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_nm_ortu
				,	{
						xtype		: 'compositefield'
					,	fieldLabel	: 'Tempat dan Tanggal Lahir'
					,	msgTarget	: 'under'
					,	items		: [
							this.form_kota_lahir
						,	{
								xtype	: 'displayfield'
							,	value	: ','
							}
						,	this.form_tanggal_lahir
						]
					}
				,	this.form_jenis_kelamin
				,	this.form_agama
				,	this.form_kewarganegaraan
				,	this.form_tingkat_ijazah
				,	this.form_gol_pekerjaan_ortu
				,	this.form_gaji
				,	this.form_alamat
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
						,	this.form_kd_pos
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
				,	this.form_status_hub
				,	this.form_status_hidup
				,	this.form_tahun_meninggal
				,	this.form_status_nikah
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
	this.do_reset = function()
	{
		this.form_nm_ortu.setValue('');
		this.form_kota_lahir.setValue('');
		this.form_tanggal_lahir.setValue('');
		this.form_jenis_kelamin.setValue('');
		this.form_agama.setValue('');
		this.form_kewarganegaraan.setValue('');
		this.form_tingkat_ijazah.setValue('');
		this.form_gol_pekerjaan_ortu.setValue('');
		this.form_gaji.setValue('');
		this.form_alamat.setValue('');
		this.form_rt.setValue('');
		this.form_rw.setValue('');
		this.form_kd_pos.setValue('');		
		this.form_no_telp.setValue('');		
		this.form_no_hp.setValue('');		
		this.form_status_hub.setValue('');	
		this.form_status_nikah.setValue('');	
		this.form_status_hidup.setValue('');	
		this.form_tahun_meninggal.setValue('');	
		
		this.form_tahun_meninggal.hide();	
	}
	
	this.edit_fill_form = function(data)
	{
		this.form_nm_ortu.setValue('');
		this.form_kota_lahir.setValue('');
		this.form_tanggal_lahir.setValue('');
		this.form_jenis_kelamin.setValue('');
		this.form_agama.setValue('');
		this.form_kewarganegaraan.setValue('');
		this.form_tingkat_ijazah.setValue('');
		this.form_gol_pekerjaan_ortu.setValue('');
		this.form_gaji.setValue('');
		this.form_alamat.setValue('');
		this.form_rt.setValue('');
		this.form_rw.setValue('');
		this.form_kd_pos.setValue('');		
		this.form_no_telp.setValue('');		
		this.form_no_hp.setValue('');		
		this.form_status_hub.setValue('');	
		this.form_status_nikah.setValue('');	
		this.form_status_hidup.setValue('');	
		this.form_tahun_meninggal.setValue('');		

		this.form_tahun_meninggal.hide();	
		
		this.form_nm_ortu.setValue(data.nm_ortu);
		this.form_kota_lahir.setValue(data.kota_lahir);
		this.form_tanggal_lahir.setValue(data.tanggal_lahir);
		this.form_jenis_kelamin.setValue(data.kd_jenis_kelamin);
		this.form_agama.setValue(data.kd_agama);
		this.form_kewarganegaraan.setValue(data.kewarganegaraan);
		this.form_tingkat_ijazah.setValue(data.kd_tingkat_ijazah);
		this.form_gol_pekerjaan_ortu.setValue(data.id_gol_pekerjaan_ortu);
		this.form_gaji.setValue(data.gaji);
		this.form_alamat.setValue(data.alamat);
		this.form_rt.setValue(data.rt);
		this.form_rw.setValue(data.rw);
		this.form_kd_pos.setValue(data.kd_pos);		
		this.form_no_telp.setValue(data.no_telp);		
		this.form_no_hp.setValue(data.no_hp);		
		this.form_status_hub.setValue(data.status_hub);		
		this.form_status_nikah.setValue(data.kd_status_nikah);		
		this.form_status_hidup.setValue(data.status_hidup);		
		this.form_tahun_meninggal.setValue(data.tahun_meninggal);
		
		if (this.form_status_nikah.getValue() == '2'){
			this.form_tahun_meninggal.show();
		} else {
			this.form_tahun_meninggal.hide();
		}
	}
	
	this.is_valid = function()
	{
		if (!this.form_nm_ortu.isValid()) {
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

		if (!this.form_tingkat_ijazah.isValid()) {
			return false;
		}

		if (!this.form_gol_pekerjaan_ortu.isValid()) {
			return false;
		}

		if (!this.form_gaji.isValid()) {
			return false;
		}

		if (!this.form_alamat.isValid()) {
			return false;
		}

		if (!this.form_status_hub.isValid()) {
			return false;
		}

		if (!this.form_status_nikah.isValid()) {
			return false;
		}

		if (!this.form_status_hidup.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				params  : {
						id_siswa						: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
					,	nm_ortu					: this.form_nm_ortu.getValue()
					,	kota_lahir				: this.form_kota_lahir.getValue()
					,	tanggal_lahir			: this.form_tanggal_lahir.getValue()
					,	kd_jenis_kelamin		: this.form_jenis_kelamin.getValue()
					,	kd_agama				: this.form_agama.getValue()
					,	kewarganegaraan			: this.form_kewarganegaraan.getValue()
					,	kd_tingkat_ijazah		: this.form_tingkat_ijazah.getValue()
					,	id_gol_pekerjaan_ortu	: this.form_gol_pekerjaan_ortu.getValue()
					,	gaji					: this.form_gaji.getValue()
					,	alamat					: this.form_alamat.getValue()
					,	rt						: this.form_rt.getValue()
					,	rw						: this.form_rw.getValue()
					,	kd_pos					: this.form_kd_pos.getValue()
					,	no_telp					: this.form_no_telp.getValue()
					,	no_hp					: this.form_no_hp.getValue()
					,	status_hub				: this.form_status_hub.getValue()
					,	kd_status_nikah			: this.form_status_nikah.getValue()
					,	status_hidup			: this.form_status_hidup.getValue()
					,	tahun_meninggal			: this.form_tahun_meninggal.getValue()
					,	dml_type				: this.dml_type
				}
			,	url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d + 'submit_detail_data_wali.jsp'
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
			url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_detail_data_wali.jsp'
		,	params	: {
				id_siswa	: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
			}
		,	waitMsg	: 'Pemuatan ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);
				
				if (msg.success == false) {
					this.do_reset();
					this.dml_type	= 2;
					return;
				}
				
				this.edit_fill_form(msg);
				this.dml_type	= 3;
			}
		,	scope	: this		
		});
	}

	this.do_refresh = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level >= 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}
	
		this.store_agama.load();
		this.store_tingkat_ijazah.load();
		this.store_gol_pekerjaan_ortu.load();
		
		this.do_load();
	}
}

function M_AdmSiswaPemeliharaanDataIndukSiswaDetailDataHobi(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* record */
	this.record = new Ext.data.Record.create([
			{ name	: 'id_siswa' }
		,	{ name	: 'id_hobi' }
		,	{ name	: 'id_hobi_old' }
		,	{ name	: 'keterangan' }
	]);

	/* store */
	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_detail_data_hobi.jsp'
		,	autoLoad	: false
	});
	
	this.store_hobi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_ref_hobi.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	/* form items */
	this.form_hobi = new Ext.form.ComboBox({
			store			: this.store_hobi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	listWidth		: 400
	});

	this.form_keterangan = new Ext.form.TextField({
			allowBlank		: true
	});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Hobi'
			, dataIndex		: 'id_hobi'
			, sortable		: true
			, editor		: this.form_hobi
			, renderer		: combo_renderer(this.form_hobi)
			, width			: 300
			, filter		: {
					type		: 'list'
				,	store		: this.store_hobi
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
			, sortable		: true
			, editor		: this.form_keterangan
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
	});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_del
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.editor, this.filters]
		,	autoExpandColumn	: 'keterangan'
		,	tbar				: this.toolbar
		,	listeners			: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.set_disabled = function()
	{
		this.btn_del.setDisabled(true);
		this.btn_ref.setDisabled(true);
		this.btn_add.setDisabled(true);
	}

	this.set_enabled = function()
	{
		this.btn_del.setDisabled(false);
		this.btn_ref.setDisabled(false);
		this.btn_add.setDisabled(false);
	}

	this.do_add = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_siswa			: ''
			,	id_hobi		: ''
			,	keterangan	: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
		
		this.set_disabled();
	}

	this.do_del = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_cancel = function()
	{
		this.set_enabled();
		
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
		
		this.set_button();
	}

	this.do_save = function(record)
	{
		this.set_enabled();
		
		Ext.Ajax.request({
				url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'submit_detail_data_hobi.jsp'
			,	params  : {
						id_siswa			: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
					,	id_hobi		: record.data['id_hobi']
					,	id_hobi_old	: record.data['id_hobi_old']
					,	keterangan	: record.data['keterangan']
					,	dml_type	: this.dml_type
				}
			,	waitMsg	: 'Mohon Tunggu ...'
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						this.do_load();
					}
			,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.set_button = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}

	this.do_load = function()
	{
		this.store_hobi.load({
			callback	: function(){
				this.store.load({
					params	: {
						id_siswa	: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
					}
				});
			}
		,	scope		: this
		});
		
		this.set_button();
	}

	this.do_refresh = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSiswaPemeliharaanDataIndukSiswaDetailDataCuti(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* record */
	this.record = new Ext.data.Record.create([
			{ name	: 'id_siswa' }
		,	{ name	: 'tanggal' }
		,	{ name	: 'tanggal_old' }
		,	{ name	: 'tanggal_masuk' }
		,	{ name	: 'keterangan' }
	]);

	/* store */
	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_detail_data_cuti.jsp'
		,	autoLoad	: false
	});
	
	/* form items */
	this.form_tanggal = new Ext.form.DateField({
			emptyText		: 'Y-m-d'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
	});

	this.form_tanggal_masuk = new Ext.form.DateField({
			emptyText		: 'Y-m-d'
		,	format			: 'Y-m-d'
		,	allowBlank		: true
		,	invalidText		: 'Kolom ini harus berformat tanggal'
	});

	this.form_keterangan = new Ext.form.TextField({
			allowBlank		: true
	});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Tanggal Cuti'
			, dataIndex		: 'tanggal'
			, sortable		: true
			, editor		: this.form_tanggal
			, align			: 'center'
			, width			: 150
			, filter		: {
					type		: 'date'
			 }
			}
		,	{ header		: 'Tanggal Masuk'
			, dataIndex		: 'tanggal_masuk'
			, sortable		: true
			, editor		: this.form_tanggal_masuk
			, align			: 'center'
			, width			: 150
			, filter		: {
					type		: 'date'
			 }
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
			, sortable		: true
			, editor		: this.form_keterangan
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
	});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_del
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.editor, this.filters]
		,	autoExpandColumn	: 'keterangan'
		,	tbar				: this.toolbar
		,	listeners			: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.set_disabled = function()
	{
		this.btn_del.setDisabled(true);
		this.btn_ref.setDisabled(true);
		this.btn_add.setDisabled(true);
	}

	this.set_enabled = function()
	{
		this.btn_del.setDisabled(false);
		this.btn_ref.setDisabled(false);
		this.btn_add.setDisabled(false);
	}

	this.do_add = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_siswa				: ''
			,	tanggal			: ''
			,	tanggal_masuk	: ''
			,	keterangan		: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
		
		this.set_disabled();
	}

	this.do_del = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_cancel = function()
	{
		this.set_enabled();
		
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
		
		this.set_button();
	}

	this.do_save = function(record)
	{
		this.set_enabled();
		
		Ext.Ajax.request({
				url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'submit_detail_data_cuti.jsp'
			,	params  : {
						id_siswa				: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
					,	tanggal			: record.data['tanggal']
					,	tanggal_old		: record.data['tanggal_old']
					,	tanggal_masuk	: record.data['tanggal_masuk']
					,	keterangan		: record.data['keterangan']
					,	dml_type		: this.dml_type
				}
			,	waitMsg	: 'Mohon Tunggu ...'
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						this.do_load();
					}
			,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.set_button = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}

	this.do_load = function()
	{
		this.store.load({
			params	: {
				id_siswa	: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
			}
		});
		
		this.set_button();
	}

	this.do_refresh = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSiswaPemeliharaanDataIndukSiswaDetailDataPindahSekolah(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* store */
	this.store_asal_smp = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_ref_asal_smp.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});
	
	/* form items */
	this.form_asal_smp = new Ext.form.ComboBox({
			fieldLabel		: 'Sekolah Tujuan'
		,	store			: this.store_asal_smp
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 250
		,	msgTarget		: 'side'
	});

	this.form_pindah_alasan = new Ext.form.TextArea({
			fieldLabel		: 'Alasan Pindah'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	/* form */
	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 175
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_asal_smp
				,	this.form_pindah_alasan
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
	this.do_reset = function()
	{
		this.form_asal_smp.setValue('');
		this.form_pindah_alasan.setValue('');
	}
	
	this.edit_fill_form = function(data)
	{
		this.form_asal_smp.setValue('');
		this.form_pindah_alasan.setValue('');

		this.form_asal_smp.setValue(data.asal_smp);
		this.form_pindah_alasan.setValue(data.pindah_alasan);
	}
	
	this.is_valid = function()
	{
		if (!this.form_asal_smp.isValid()) {
			return false;
		}

		if (!this.form_pindah_alasan.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				params  : {
						id_siswa				: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
					,	asal_smp		: this.form_asal_smp.getValue()
					,	pindah_alasan	: this.form_pindah_alasan.getValue()
					,	dml_type		: this.dml_type
				}
			,	url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d + 'submit_detail_data_pindah_sekolah.jsp'
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
			url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_detail_data_pindah_sekolah.jsp'
		,	params	: {
				id_siswa	: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
			}
		,	waitMsg	: 'Pemuatan ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);
				
				if (msg.success == false) {
					this.do_reset();
					this.dml_type	= 2;
					return;
				}
				
				this.edit_fill_form(msg);
				this.dml_type	= 3;
			}
		,	scope	: this		
		});
	}

	this.do_refresh = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level >= 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}
	
		this.store_asal_smp.load();
		
		this.do_load();
	}
}

function M_AdmSiswaPemeliharaanDataIndukSiswaDetailDataPutusSekolah(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* form items */
	this.form_tanggal_keluar = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Keluar'
		,	emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	invalidText		: 'Kolom ini harus berformat tanggal'
		,	allowBlank		: false
		,	editable		: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_alasan_keluar = new Ext.form.TextArea({
			fieldLabel		: 'Alasan Keluar'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	/* form */
	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 175
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_tanggal_keluar
				,	this.form_alasan_keluar
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
	this.do_reset = function()
	{
		this.form_tanggal_keluar.setValue('');
		this.form_alasan_keluar.setValue('');
	}
	
	this.edit_fill_form = function(data)
	{
		this.form_tanggal_keluar.setValue('');
		this.form_alasan_keluar.setValue('');

		this.form_tanggal_keluar.setValue(data.tanggal_keluar);
		this.form_alasan_keluar.setValue(data.alasan_keluar);
	}
	
	this.is_valid = function()
	{
		if (!this.form_tanggal_keluar.isValid()) {
			return false;
		}

		if (!this.form_alasan_keluar.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				params  : {
						id_siswa				: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
					,	tanggal_keluar	: this.form_tanggal_keluar.getValue()
					,	alasan_keluar	: this.form_alasan_keluar.getValue()
					,	dml_type		: this.dml_type
				}
			,	url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d + 'submit_detail_data_putus_sekolah.jsp'
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
			url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_detail_data_putus_sekolah.jsp'
		,	params	: {
				id_siswa	: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
			}
		,	waitMsg	: 'Pemuatan ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);
				
				if (msg.success == false) {
					this.do_reset();
					this.dml_type	= 2;
					return;
				}
				
				this.edit_fill_form(msg);
				this.dml_type	= 3;
			}
		,	scope	: this		
		});
	}

	this.do_refresh = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level >= 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}
	
		this.do_load();
	}
}

function M_AdmSiswaPemeliharaanDataIndukSiswaDetailRiwayatSakit(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* record */
	this.record = new Ext.data.Record.create([
			{ name	: 'id_siswa' }
		,	{ name	: 'no_urut' }
		,	{ name	: 'no_urut_old' }
		,	{ name	: 'id_penyakit' }
		,	{ name	: 'lama_sakit' }
		,	{ name	: 'keterangan' }
	]);

	/* store */
	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_detail_data_riwayat_sakit.jsp'
		,	autoLoad	: false
	});
	
	this.store_penyakit = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_ref_penyakit.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	/* form items */
	this.form_no_urut = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
	});

	this.form_penyakit = new Ext.form.ComboBox({
			store			: this.store_penyakit
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	listWidth		: 300
	});

	this.form_lama_sakit = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
	});

	this.form_keterangan = new Ext.form.TextField({
			allowBlank		: true
	});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'No.Urut'
			, dataIndex		: 'no_urut'
			, sortable		: true
			, editor		: this.form_no_urut
			, align			: 'center'
			, width			: 60
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ header		: 'Penyakit'
			, dataIndex		: 'id_penyakit'
			, sortable		: true
			, editor		: this.form_penyakit
			, renderer		: combo_renderer(this.form_penyakit)
			, width			: 200
			, filter		: {
					type		: 'list'
				,	store		: this.store_penyakit
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Lama Sakit'
			, dataIndex		: 'lama_sakit'
			, sortable		: true
			, editor		: this.form_lama_sakit
			, align			: 'center'
			, width			: 100
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
			, sortable		: true
			, editor		: this.form_keterangan
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
	});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_del
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.editor, this.filters]
		,	autoExpandColumn	: 'keterangan'
		,	tbar				: this.toolbar
		,	listeners			: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.set_disabled = function()
	{
		this.btn_del.setDisabled(true);
		this.btn_ref.setDisabled(true);
		this.btn_add.setDisabled(true);
	}

	this.set_enabled = function()
	{
		this.btn_del.setDisabled(false);
		this.btn_ref.setDisabled(false);
		this.btn_add.setDisabled(false);
	}

	this.do_add = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_siswa	: ''
			,	no_urut		: ''
			,	id_penyakit	: ''
			,	lama_sakit	: ''
			,	keterangan	: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
		
		this.set_disabled();
	}

	this.do_del = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_cancel = function()
	{
		this.set_enabled();
		
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
		
		this.set_button();
	}

	this.do_save = function(record)
	{
		this.set_enabled();
		
		Ext.Ajax.request({
				url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'submit_detail_data_riwayat_sakit.jsp'
			,	params  : {
						id_siswa	: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
					,	no_urut		: record.data['no_urut']
					,	no_urut_old	: record.data['no_urut_old']
					,	id_penyakit	: record.data['id_penyakit']
					,	lama_sakit	: record.data['lama_sakit']
					,	keterangan	: record.data['keterangan']
					,	dml_type	: this.dml_type
				}
			,	waitMsg	: 'Mohon Tunggu ...'
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						this.do_load();
					}
			,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.set_button = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}

	this.do_load = function()
	{
		this.store_penyakit.load({
			callback	: function(){
				this.store.load({
					params	: {
						id_siswa	: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
					}
				});
			}
		,	scope		: this
		});
		
		this.set_button();
	}

	this.do_refresh = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSiswaPemeliharaanDataIndukSiswaDetailBeasiswa(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* record */
	this.record = new Ext.data.Record.create([
			{ name	: 'id_siswa' }
		,	{ name	: 'kd_beasiswa' }
		,	{ name	: 'kd_beasiswa_old' }
		,	{ name	: 'tahun_masuk' }
		,	{ name	: 'tahun_masuk_old' }
		,	{ name	: 'jumlah_beasiswa_per_bulan' }
		,	{ name	: 'keterangan' }
	]);

	/* store */
	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_detail_data_beasiswa.jsp'
		,	autoLoad	: false
	});
	
	this.store_beasiswa = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_ref_beasiswa.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	/* form items */
	this.form_beasiswa = new Ext.form.ComboBox({
			store			: this.store_beasiswa
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	listWidth		: 300
	});

	this.form_tahun_masuk = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom adalah 4'
	});

	this.form_jumlah_beasiswa_per_bulan = new Ext.ux.NumericField({
			allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
	});

	this.form_keterangan = new Ext.form.TextField({
			allowBlank		: true
	});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Nama Beasiswa'
			, dataIndex		: 'kd_beasiswa'
			, sortable		: true
			, editor		: this.form_beasiswa
			, renderer		: combo_renderer(this.form_beasiswa)
			, width			: 200
			, filter		: {
					type		: 'list'
				,	store		: this.store_beasiswa
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Tahun Masuk'
			, dataIndex		: 'tahun_masuk'
			, sortable		: true
			, editor		: this.form_tahun_masuk
			, align			: 'center'
			, width			: 90
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ header		: 'Jumlah Beasiswa per Bulan'
			, dataIndex		: 'jumlah_beasiswa_per_bulan'
			, sortable		: true
			, editor		: this.form_jumlah_beasiswa_per_bulan
			, align			: 'right'
			, width			: 180
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
			, sortable		: true
			, editor		: this.form_keterangan
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
	});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_del
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.editor, this.filters]
		,	autoExpandColumn	: 'keterangan'
		,	tbar				: this.toolbar
		,	listeners			: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.set_disabled = function()
	{
		this.btn_del.setDisabled(true);
		this.btn_ref.setDisabled(true);
		this.btn_add.setDisabled(true);
	}

	this.set_enabled = function()
	{
		this.btn_del.setDisabled(false);
		this.btn_ref.setDisabled(false);
		this.btn_add.setDisabled(false);
	}

	this.do_add = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_siswa							: ''
			,	kd_beasiswa					: ''
			,	tahun_masuk					: ''
			,	jumlah_beasiswa_per_bulan	: ''
			,	keterangan					: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
		
		this.set_disabled();
	}

	this.do_del = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_cancel = function()
	{
		this.set_enabled();
		
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
		
		this.set_button();
	}

	this.do_save = function(record)
	{
		this.set_enabled();
		
		Ext.Ajax.request({
				url		: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'submit_detail_data_beasiswa.jsp'
			,	params  : {
						id_siswa							: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
					,	kd_beasiswa					: record.data['kd_beasiswa']
					,	kd_beasiswa_old				: record.data['kd_beasiswa_old']
					,	tahun_masuk					: record.data['tahun_masuk']
					,	tahun_masuk_old				: record.data['tahun_masuk_old']
					,	jumlah_beasiswa_per_bulan	: record.data['jumlah_beasiswa_per_bulan']
					,	keterangan					: record.data['keterangan']
					,	dml_type					: this.dml_type
				}
			,	waitMsg	: 'Mohon Tunggu ...'
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						this.do_load();
					}
			,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Siswa terlebih dahulu!");
			return;
		}

		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.set_button = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}

	this.do_load = function()
	{
		this.store_beasiswa.load({
			callback	: function(){
				this.store.load({
					params	: {
						id_siswa	: m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa
					}
				});
			}
		,	scope		: this
		});
		
		this.set_button();
	}

	this.do_refresh = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSiswaPemeliharaanDataIndukSiswaMaster(title)
{
	this.title		= title;
	this.pageSize	= 30;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_siswa' }
		,	{ name	: 'nis' }
		,	{ name	: 'nm_siswa' }
		,	{ name	: 'alamat' }
	]);

	this.store = new Ext.ux.data.PagingArrayStore({
			fields		: this.record
		,	url			: m_adm_siswa_pemeliharaan_data_induk_siswa_d +'data_master.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
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
		,	{ header		: 'NIS'
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
						m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa = data[0].data['id_siswa'];						
					} else {
						m_adm_siswa_pemeliharaan_data_induk_siswa_id_siswa = '';
					}
					
					m_adm_siswa_pemeliharaan_data_induk_siswa_master_on_select_load_detail();
				}
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

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'north'
		,	height				: 250
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

	this.do_load = function()
	{
		delete this.store.lastParams;
		
		this.store.load({
			params	: {
				start	: 0
			,	limit	: this.pageSize
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSiswaPemeliharaanDataIndukSiswa()
{
	m_adm_siswa_pemeliharaan_data_induk_siswa_master						= new M_AdmSiswaPemeliharaanDataIndukSiswaMaster('Pemeliharaan Data Induk Siswa');
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_info_siswa				= new M_AdmSiswaPemeliharaanDataIndukSiswaDetailInfoSiswa('Info Siswa');
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_ayah				= new M_AdmSiswaPemeliharaanDataIndukSiswaDetailDataAyah('Data Ayah');
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_ibu				= new M_AdmSiswaPemeliharaanDataIndukSiswaDetailDataIbu('Data Ibu');
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_wali				= new M_AdmSiswaPemeliharaanDataIndukSiswaDetailDataWali('Data Wali');
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_hobi				= new M_AdmSiswaPemeliharaanDataIndukSiswaDetailDataHobi('Data Hobi');
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_cuti				= new M_AdmSiswaPemeliharaanDataIndukSiswaDetailDataCuti('Data Cuti');
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_pindah_sekolah	= new M_AdmSiswaPemeliharaanDataIndukSiswaDetailDataPindahSekolah('Data Pindah Sekolah');
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_putus_sekolah		= new M_AdmSiswaPemeliharaanDataIndukSiswaDetailDataPutusSekolah('Data Putus Sekolah');
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_riwayat_sakit			= new M_AdmSiswaPemeliharaanDataIndukSiswaDetailRiwayatSakit('Riwayat Sakit');
	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_beasiswa				= new M_AdmSiswaPemeliharaanDataIndukSiswaDetailBeasiswa('Beasiswa');

	this.panel_detail = new Ext.TabPanel({
			autoScroll		: true
		,	enableTabScroll	: true
		,	region			: 'center'
        ,	activeTab		: 0
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    		}
		,	items			: [
				m_adm_siswa_pemeliharaan_data_induk_siswa_detail_info_siswa.panel
			,	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_ayah.panel
			,	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_ibu.panel
			,	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_wali.panel
			,	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_hobi.panel
			,	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_cuti.panel
			,	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_pindah_sekolah.panel
			,	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_data_putus_sekolah.panel
			,	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_riwayat_sakit.panel
			,	m_adm_siswa_pemeliharaan_data_induk_siswa_detail_beasiswa.panel
			]
	});

	this.panel = new Ext.Panel({
			id				: 'adm_siswa_pemeliharaan_data_induk_siswa_panel'
		,	layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoWidth		: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_adm_siswa_pemeliharaan_data_induk_siswa_master.panel
			,	this.panel_detail
			]
	});
	
	this.do_refresh = function(ha_level)
	{
		m_adm_siswa_pemeliharaan_data_induk_siswa_ha_level = ha_level;
		
		m_adm_siswa_pemeliharaan_data_induk_siswa_master.do_refresh();
	}
}

m_adm_siswa_pemeliharaan_data_induk_siswa = new M_AdmSiswaPemeliharaanDataIndukSiswa();

//@ sourceURL=adm_siswa_pemeliharaan_data_induk_siswa.layout.js
