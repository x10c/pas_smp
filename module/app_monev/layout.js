/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_app_monev;
var m_app_monev_d = _g_root +'/module/app_monev/';
var m_app_monev_ha_level = 0;

function M_AppMonev(title)
{
	this.title			= title;

	/* form items */
	this.form_referensi = new Ext.form.NumberField({
			fieldLabel		: 'Referensi'
		,	readOnly		: true
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_properti_sekolah = new Ext.form.NumberField({
			fieldLabel		: 'Properti Sekolah'
		,	readOnly		: true
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_perlengkapan_sekolah = new Ext.form.NumberField({
			fieldLabel		: 'Perlengkapan Sekolah'
		,	readOnly		: true
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_perlengkapan_kbm = new Ext.form.NumberField({
			fieldLabel		: 'Perlengkapan KBM'
		,	readOnly		: true
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_ruangan = new Ext.form.NumberField({
			fieldLabel		: 'Ruangan'
		,	readOnly		: true
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_bualpen = new Ext.form.NumberField({
			fieldLabel		: 'Buku dan Alat Pendidikan'
		,	readOnly		: true
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_pendukung_lism = new Ext.form.NumberField({
			fieldLabel		: 'Pendukung LISM'
		,	readOnly		: true
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_keuangan = new Ext.form.NumberField({
			fieldLabel		: 'Keuangan'
		,	readOnly		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_bantuan = new Ext.form.NumberField({
			fieldLabel		: 'Bantuan'
		,	readOnly		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_kepala_sekolah = new Ext.form.NumberField({
			fieldLabel		: 'Kepala Sekolah'
		,	readOnly		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_guru = new Ext.form.NumberField({
			fieldLabel		: 'Guru'
		,	readOnly		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_tenaga_administrasi = new Ext.form.NumberField({
			fieldLabel		: 'Tenaga Administrasi'
		,	readOnly		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_siswa = new Ext.form.NumberField({
			fieldLabel		: 'Siswa'
		,	readOnly		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_rombongan_belajar = new Ext.form.NumberField({
			fieldLabel		: 'Rombongan Belajar'
		,	readOnly		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_penentuan_kelas = new Ext.form.NumberField({
			fieldLabel		: 'Penentuan Kelas'
		,	readOnly		: true
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
					{
						xtype		: 'fieldset'
					,	title		: 'DATA REFERENSI'
					,	collapsible	: true
					,	items		: [
							{
								xtype	: 'compositefield'
							,	title	: 'Referensi'
							,	items	: [
									this.form_referensi
								,	{
										xtype	: 'displayfield'
									,	value	: '%'
									}
								]
							}
						]
					}
				,	{
						xtype		: 'fieldset'
					,	title		: 'DATA FASILITAS SEKOLAH'
					,	collapsible	: true
					,	items		: [
							{
								xtype	: 'compositefield'
							,	title	: 'Properti Sekolah'
							,	items	: [
									this.form_properti_sekolah
								,	{
										xtype	: 'displayfield'
									,	value	: '%'
									}
								]
							}
						,	{
								xtype	: 'compositefield'
							,	title	: 'Perlengkapan Sekolah'
							,	items	: [
									this.form_perlengkapan_sekolah
								,	{
										xtype	: 'displayfield'
									,	value	: '%'
									}
								]
							}
						,	{
								xtype	: 'compositefield'
							,	title	: 'Perlengkapan KBM'
							,	items	: [
									this.form_perlengkapan_kbm
								,	{
										xtype	: 'displayfield'
									,	value	: '%'
									}
								]
							}
						,	{
								xtype	: 'compositefield'
							,	title	: 'Ruangan Sekolah'
							,	items	: [
									this.form_ruangan
								,	{
										xtype	: 'displayfield'
									,	value	: '%'
									}
								]
							}
						,	{
								xtype	: 'compositefield'
							,	title	: 'Buku dan Alat Pendidikan'
							,	items	: [
									this.form_bualpen
								,	{
										xtype	: 'displayfield'
									,	value	: '%'
									}
								]
							}
						]
					}
				,	{
						xtype		: 'fieldset'
					,	title		: 'DATA DETAIL SEKOLAH'
					,	collapsible	: true
					,	items		: [
							{
								xtype	: 'compositefield'
							,	title	: 'Pendukung LISM'
							,	items	: [
									this.form_pendukung_lism
								,	{
										xtype	: 'displayfield'
									,	value	: '%'
									}
								]
							}
						,	this.form_keuangan
						,	this.form_bantuan
						]
					}
				,	{
						xtype		: 'fieldset'
					,	title		: 'DATA PEGAWAI DAN SISWA'
					,	collapsible	: true
					,	items		: [
							this.form_kepala_sekolah
						,	this.form_guru
						,	this.form_tenaga_administrasi
						,	this.form_siswa
						,	this.form_rombongan_belajar
						,	this.form_penentuan_kelas
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

	/* panel */
	this.panel = new Ext.Panel({
			title		: this.title
		,	autoWidth	: true
		,	autoScroll	: true
		,	padding		:'6'
		,	tbar		: [
				this.btn_ref
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
		this.form_referensi.setValue(data.referensi);
		this.form_properti_sekolah.setValue(data.properti_sekolah);
		this.form_perlengkapan_sekolah.setValue(data.perlengkapan_sekolah);
		this.form_perlengkapan_kbm.setValue(data.perlengkapan_kbm);
		this.form_ruangan.setValue(data.ruangan);
		this.form_bualpen.setValue(data.bualpen);
		this.form_pendukung_lism.setValue(data.pendukung_lism);
		this.form_keuangan.setValue(data.keuangan);
		this.form_bantuan.setValue(data.bantuan);
		this.form_kepala_sekolah.setValue(data.kepala_sekolah);
		this.form_guru.setValue(data.guru);
		this.form_tenaga_administrasi.setValue(data.tenaga_administrasi);
		this.form_siswa.setValue(data.siswa);
		this.form_rombongan_belajar.setValue(data.rombongan_belajar);
		this.form_penentuan_kelas.setValue(data.penentuan_kelas);
	}
	
	this.do_load = function()
	{
		Ext.Ajax.request({
			url		: m_app_monev_d +'data.jsp'
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
		m_app_monev_ha_level = ha_level;
		
		if (m_app_monev_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

m_app_monev = new M_AppMonev('Monitoring Evaluasi');

//@ sourceURL=app_monev.layout.js
