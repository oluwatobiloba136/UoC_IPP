USE [AFRINVESTLIVE]
GO

/****** Object:  Table [dbo].[AFRINVEST CONSOLIDATED$G_L Entry]    Script Date: 08/03/2023 16:11:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AFRINVEST CONSOLIDATED$G_L Entry](
	[timestamp] [timestamp] NOT NULL,
	[Entry No_] [int] NOT NULL,
	[G_L Account No_] [nvarchar](20) NOT NULL,
	[Posting Date] [datetime] NOT NULL,
	[Document Type] [int] NOT NULL,
	[Document No_] [nvarchar](20) NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
	[Bal_ Account No_] [nvarchar](20) NOT NULL,
	[Amount] [decimal](38, 20) NOT NULL,
	[Global Dimension 1 Code] [nvarchar](20) NOT NULL,
	[Global Dimension 2 Code] [nvarchar](20) NOT NULL,
	[User ID] [nvarchar](50) NOT NULL,
	[Source Code] [nvarchar](10) NOT NULL,
	[System-Created Entry] [tinyint] NOT NULL,
	[Prior-Year Entry] [tinyint] NOT NULL,
	[Job No_] [nvarchar](20) NOT NULL,
	[Quantity] [decimal](38, 20) NOT NULL,
	[VAT Amount] [decimal](38, 20) NOT NULL,
	[Business Unit Code] [nvarchar](10) NOT NULL,
	[Journal Batch Name] [nvarchar](10) NOT NULL,
	[Reason Code] [nvarchar](10) NOT NULL,
	[Gen_ Posting Type] [int] NOT NULL,
	[Gen_ Bus_ Posting Group] [nvarchar](10) NOT NULL,
	[Gen_ Prod_ Posting Group] [nvarchar](10) NOT NULL,
	[Bal_ Account Type] [int] NOT NULL,
	[Transaction No_] [int] NOT NULL,
	[Debit Amount] [decimal](38, 20) NOT NULL,
	[Credit Amount] [decimal](38, 20) NOT NULL,
	[Document Date] [datetime] NOT NULL,
	[External Document No_] [nvarchar](35) NOT NULL,
	[Source Type] [int] NOT NULL,
	[Source No_] [nvarchar](20) NOT NULL,
	[No_ Series] [nvarchar](10) NOT NULL,
	[Tax Area Code] [nvarchar](20) NOT NULL,
	[Tax Liable] [tinyint] NOT NULL,
	[Tax Group Code] [nvarchar](10) NOT NULL,
	[Use Tax] [tinyint] NOT NULL,
	[VAT Bus_ Posting Group] [nvarchar](10) NOT NULL,
	[VAT Prod_ Posting Group] [nvarchar](10) NOT NULL,
	[Additional-Currency Amount] [decimal](38, 20) NOT NULL,
	[Add_-Currency Debit Amount] [decimal](38, 20) NOT NULL,
	[Add_-Currency Credit Amount] [decimal](38, 20) NOT NULL,
	[Close Income Statement Dim_ ID] [int] NOT NULL,
	[IC Partner Code] [nvarchar](20) NOT NULL,
	[Reversed] [tinyint] NOT NULL,
	[Reversed by Entry No_] [int] NOT NULL,
	[Reversed Entry No_] [int] NOT NULL,
	[Dimension Set ID] [int] NOT NULL,
	[Prod_ Order No_] [nvarchar](20) NOT NULL,
	[FA Entry Type] [int] NOT NULL,
	[FA Entry No_] [int] NOT NULL,
	[Consignment Code] [nvarchar](20) NOT NULL,
	[FA WIP No_] [nvarchar](20) NOT NULL,
 CONSTRAINT [AFRINVEST CONSOLIDATED$G_L Entry$0] PRIMARY KEY CLUSTERED 
(
	[Entry No_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Data Filegroup 1]
) ON [Data Filegroup 1]

GO






USE [AFRINVESTLIVE]
GO

/****** Object:  Table [dbo].[AFRINVEST CONSOLIDATED$G_L Entry]    Script Date: 08/03/2023 16:11:36 ******/


CREATE VIEW vAwail_GLentry as
select *
from  [dbo].[AWAL$G_L Entry]
where YEAR([Posting Date]) = 2022 