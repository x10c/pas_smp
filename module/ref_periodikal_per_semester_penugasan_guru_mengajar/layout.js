/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_ref_periodikal_per_semester_penugasan_guru_mengajar;
var m_ref_periodikal_per_semester_penugasan_guru_mengajar_master;
var m_ref_periodikal_per_semester_penugasan_guru_mengajar_detail;
var m_ref_periodikal_per_semester_penugasan_guru_mengajar_d = _g_root +'/module/ref_periodikal_per_semester_penugasan_guru_mengajar/';
var m_ref_periodikal_per_semester_penugasan_guru_mengajar_kd_tahun_ajaran = '';
var m_ref_periodikal_per_semester_penugasan_guru_mengajar_nip = '';
var m_ref_periodikal_per_semester_penugasan_guru_mengajar_ha_level = 0;

function m_ref_periodikal_per_semester_penugasan_guru_mengajar_master_on_select_load_detail()
{
 	if (typeof m_ref_periodikal_per_semester_penugasan_guru_mengajar_master == 'undefined'
	||  typeof m_ref_periodikal_per_semester_penugasan_guru_mengajar_detail == 'undefined'
	||	m_ref_periodikal_per_semester_penugasan_guru_mengajar_kd_tahun_ajaran == ''
	||	m_ref_periodikal_per_semester_penugasan_guru_mengajar_nip == '') {
		return;
	}

	m_ref_periodikal_per_semester_penugasan_guru_mengajar_detail.do_refresh();
}

function M_RefPeriodikalPerSemesterPenugasanGuruMengajarMaster(title)
{
	this.title		= title;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'nip' }
		,	{ name	: 'nomor_induk' }
		,	{ name	: 'nip_baru' }
		,	{ name	: 'nm_pegawai' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_ref_periodikal_per_semester_penugasan_guru_mengajar_d +'data_master.jsp'
		,	autoLoad	: false
	});
	
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'NIP'
			, dataIndex		: 'nomor_induk'
			, sortable		: true
			, align			: 'center'
			, width			: 100
			}
		,	{ header		: 'NIP Baru'
			, dataIndex		: 'nip_baru'
			, sortable		: true
			, align			: 'center'
			, width			: 150
			}
		,	{ id			: 'nm_pegawai'
			, header		: 'Nama Pegawai'
			, dataIndex		: 'nm_pegawai'
			, sortable		: true
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners		: {
					scope			: this
				,	selectionchange	: function(sm) {
						var data = sm.getSelections();
						if (data.length) {
							m_ref_periodikal_per_semester_penugasan_guru_mengajar_kd_tahun_ajaran	= data[0].data['kd_tahun_ajaran'];
							m_ref_periodikal_per_semester_penugasan_guru_mengajar_nip				= data[0].data['nip'];
						} else {
							m_ref_periodikal_per_semester_penugasan_guru_mengajar_kd_tahun_ajaran	= '';
							m_ref_periodikal_per_semester_penugasan_guru_mengajar_nip				= '';
						}

						m_ref_periodikal_per_semester_penugasan_guru_mengajar_master_on_select_load_detail();
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

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'north'
		,	height				: 200
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'nm_pegawai'
	});

	this.do_load = function()
	{
		this.store.load();

		m_ref_periodikal_per_semester_penugasan_guru_mengajar_kd_tahun_ajaran	= '';
		m_ref_periodikal_per_semester_penugasan_guru_mengajar_nip				= '';
		
		m_ref_periodikal_per_semester_penugasan_guru_mengajar_detail.do_load();
	}

	this.do_refresh = function()
	{
		if (m_ref_periodikal_per_semester_penugasan_guru_mengajar_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		this.do_load();
	}
}

function M_RefPeriodikalPerSemesterPenugasanGuruMengajarDetail(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'nip' }
		,	{ name	: 'kd_mata_pelajaran_diajarkan' }
		,	{ name	: 'kd_mata_pelajaran_diajarkan_old' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_ref_periodikal_per_semester_penugasan_guru_mengajar_d +'data_detail.jsp'
		,	autoLoad	: false
	});

	this.store_mata_pelajaran_diajarkan = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_ref_periodikal_per_semester_penugasan_guru_mengajar_d +'data_mata_pelajaran_diajarkan.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});
	
	this.form_mata_pelajaran_diajarkan = new Ext.form.ComboBox({
			store			: this.store_mata_pelajaran_diajarkan
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Mata Pelajaran Diajarkan'
			, dataIndex		: 'kd_mata_pelajaran_diajarkan'
			, sortable		: true
			, editor		: this.form_mata_pelajaran_diajarkan
			, renderer		: combo_renderer(this.form_mata_pelajaran_diajarkan)
			, width			: 400
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_ref_periodikal_per_semester_penugasan_guru_mengajar_ha_level == 4) {
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

	this.grid = new Ext.grid.GridPanel({
			title		: this.title
		,	region		: 'center'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	listeners	: {
					scope		: this
				,	rowclick	: function (g, r, e) {
						return this.do_edit(r);
					}
			}
	});

	this.do_add = function()
	{
		if (m_ref_periodikal_per_semester_penugasan_guru_mengajar_kd_tahun_ajaran == '' || m_ref_periodikal_per_semester_penugasan_guru_mengajar_nip == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Pegawai terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				kd_tahun_ajaran				: ''
			,	nip							: ''
			,	kd_mata_pelajaran_diajarkan	: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		if (m_ref_periodikal_per_semester_penugasan_guru_mengajar_kd_tahun_ajaran == '' || m_ref_periodikal_per_semester_penugasan_guru_mengajar_nip == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Pegawai terlebih dahulu!");
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
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
				params  : {
						kd_tahun_ajaran					: m_ref_periodikal_per_semester_penugasan_guru_mengajar_kd_tahun_ajaran
					,	nip								: m_ref_periodikal_per_semester_penugasan_guru_mengajar_nip
					,	kd_mata_pelajaran_diajarkan		: record.data['kd_mata_pelajaran_diajarkan']
					,	kd_mata_pelajaran_diajarkan_old	: record.data['kd_mata_pelajaran_diajarkan_old']
					,	dml_type						: this.dml_type
				}
			,	url		: m_ref_periodikal_per_semester_penugasan_guru_mengajar_d +'submit.jsp'
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
		if (m_ref_periodikal_per_semester_penugasan_guru_mengajar_kd_tahun_ajaran == '' || m_ref_periodikal_per_semester_penugasan_guru_mengajar_nip == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Pegawai terlebih dahulu!");
			return;
		}

		if (m_ref_periodikal_per_semester_penugasan_guru_mengajar_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store_mata_pelajaran_diajarkan.load({
				callback	: function(){
					this.store.load({
						params	: {
								kd_tahun_ajaran	: m_ref_periodikal_per_semester_penugasan_guru_mengajar_kd_tahun_ajaran
							,	nip				: m_ref_periodikal_per_semester_penugasan_guru_mengajar_nip
						}
					});
				}
			,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_periodikal_per_semester_penugasan_guru_mengajar_ha_level < 1) {
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_ref_periodikal_per_semester_penugasan_guru_mengajar_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_ref_periodikal_per_semester_penugasan_guru_mengajar_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}

}

function M_RefPeriodikalPerSemesterPenugasanGuruMengajar()
{
	m_ref_periodikal_per_semester_penugasan_guru_mengajar_master	= new M_RefPeriodikalPerSemesterPenugasanGuruMengajarMaster('Pegawai');
	m_ref_periodikal_per_semester_penugasan_guru_mengajar_detail	= new M_RefPeriodikalPerSemesterPenugasanGuruMengajarDetail('Penugasan Guru Mengajar');
	
	this.panel = new Ext.Panel({
			id			: 'ref_periodikal_per_semester_penugasan_guru_mengajar_panel'
		,	layout		: 'border'
		,	bodyBorder	: false
		,	defaults	: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_ref_periodikal_per_semester_penugasan_guru_mengajar_master.grid
			,	m_ref_periodikal_per_semester_penugasan_guru_mengajar_detail.grid
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_ref_periodikal_per_semester_penugasan_guru_mengajar_ha_level	= ha_level;
		m_ref_periodikal_per_semester_penugasan_guru_mengajar_kd_tahun_ajaran = '';
		m_ref_periodikal_per_semester_penugasan_guru_mengajar_nip = '';

		m_ref_periodikal_per_semester_penugasan_guru_mengajar_master.do_refresh(ha_level);
	}

}

m_ref_periodikal_per_semester_penugasan_guru_mengajar = new M_RefPeriodikalPerSemesterPenugasanGuruMengajar();

//@ sourceURL=ref_periodikal_per_semester_penugasan_guru_mengajar.layout.js
