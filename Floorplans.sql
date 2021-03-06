USE [master]
GO
/****** Object:  Database [FloorPlans]    Script Date: 06/30/2022 8:03:35 PM ******/
CREATE DATABASE [FloorPlans]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FloorPlans', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\FloorPlans.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FloorPlans_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\FloorPlans_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [FloorPlans] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FloorPlans].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FloorPlans] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FloorPlans] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FloorPlans] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FloorPlans] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FloorPlans] SET ARITHABORT OFF 
GO
ALTER DATABASE [FloorPlans] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FloorPlans] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FloorPlans] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FloorPlans] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FloorPlans] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FloorPlans] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FloorPlans] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FloorPlans] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FloorPlans] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FloorPlans] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FloorPlans] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FloorPlans] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FloorPlans] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FloorPlans] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FloorPlans] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FloorPlans] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FloorPlans] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FloorPlans] SET RECOVERY FULL 
GO
ALTER DATABASE [FloorPlans] SET  MULTI_USER 
GO
ALTER DATABASE [FloorPlans] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FloorPlans] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FloorPlans] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FloorPlans] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FloorPlans] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FloorPlans] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'FloorPlans', N'ON'
GO
ALTER DATABASE [FloorPlans] SET QUERY_STORE = OFF
GO
USE [FloorPlans]
GO
/****** Object:  Table [dbo].[tblAccessLevel]    Script Date: 06/30/2022 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccessLevel](
	[AccessId] [int] IDENTITY(1,1) NOT NULL,
	[EditAccess] [bit] NULL,
	[DeleteAccess] [bit] NULL,
	[CreateAccess] [bit] NULL,
	[MenuId] [int] NULL,
	[RoleId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[EditBy] [int] NULL,
	[EditDate] [datetime] NULL,
	[isActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AccessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMenu]    Script Date: 06/30/2022 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMenu](
	[MenuId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ControllerName] [nvarchar](50) NULL,
	[ActionName] [nvarchar](50) NULL,
	[isParent] [bit] NULL,
	[ParentId] [int] NULL,
	[FontAwesome] [nvarchar](50) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[EditBy] [int] NULL,
	[EditDate] [datetime] NULL,
	[isActive] [bit] NULL,
	[ElementId] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRole]    Script Date: 06/30/2022 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRole](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[Role] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[EditBy] [int] NULL,
	[EditDate] [datetime] NULL,
	[isActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 06/30/2022 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[FirstName] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[Password] [nvarchar](max) NULL,
	[RoleId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[EditBy] [int] NULL,
	[EditDate] [datetime] NULL,
	[isActive] [bit] NULL,
 CONSTRAINT [PK__tblUser__1788CC4CF61B627F] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblAccessLevel] ON 

INSERT [dbo].[tblAccessLevel] ([AccessId], [EditAccess], [DeleteAccess], [CreateAccess], [MenuId], [RoleId], [CreatedBy], [CreatedDate], [EditBy], [EditDate], [isActive]) VALUES (1, 0, 0, 0, 3, 1, 1, CAST(N'2022-06-28T15:39:19.357' AS DateTime), 1, CAST(N'2022-06-28T15:39:19.357' AS DateTime), 1)
INSERT [dbo].[tblAccessLevel] ([AccessId], [EditAccess], [DeleteAccess], [CreateAccess], [MenuId], [RoleId], [CreatedBy], [CreatedDate], [EditBy], [EditDate], [isActive]) VALUES (2, 0, 0, 0, 4, 1, 1, CAST(N'2022-06-28T15:39:19.560' AS DateTime), 1, CAST(N'2022-06-28T15:39:19.560' AS DateTime), 1)
INSERT [dbo].[tblAccessLevel] ([AccessId], [EditAccess], [DeleteAccess], [CreateAccess], [MenuId], [RoleId], [CreatedBy], [CreatedDate], [EditBy], [EditDate], [isActive]) VALUES (3, 0, 0, 0, 5, 1, 1, CAST(N'2022-06-28T15:39:19.567' AS DateTime), 1, CAST(N'2022-06-28T15:39:19.567' AS DateTime), 1)
INSERT [dbo].[tblAccessLevel] ([AccessId], [EditAccess], [DeleteAccess], [CreateAccess], [MenuId], [RoleId], [CreatedBy], [CreatedDate], [EditBy], [EditDate], [isActive]) VALUES (4, 0, 0, 0, 6, 1, 1, CAST(N'2022-06-28T15:39:19.570' AS DateTime), 1, CAST(N'2022-06-28T15:39:19.570' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tblAccessLevel] OFF
GO
SET IDENTITY_INSERT [dbo].[tblMenu] ON 

INSERT [dbo].[tblMenu] ([MenuId], [Name], [ControllerName], [ActionName], [isParent], [ParentId], [FontAwesome], [CreatedBy], [CreatedDate], [EditBy], [EditDate], [isActive], [ElementId]) VALUES (3, N'Dashboard', N'Home', N'Index', 0, 0, N'fe fe-home', NULL, NULL, NULL, NULL, 1, N'Dashboard')
INSERT [dbo].[tblMenu] ([MenuId], [Name], [ControllerName], [ActionName], [isParent], [ParentId], [FontAwesome], [CreatedBy], [CreatedDate], [EditBy], [EditDate], [isActive], [ElementId]) VALUES (4, N'User Management', N'User', NULL, 1, 0, N'fa fa-users', NULL, NULL, NULL, NULL, 1, N'UM')
INSERT [dbo].[tblMenu] ([MenuId], [Name], [ControllerName], [ActionName], [isParent], [ParentId], [FontAwesome], [CreatedBy], [CreatedDate], [EditBy], [EditDate], [isActive], [ElementId]) VALUES (5, N'Users', N'User', N'Users', 0, 4, N'fa fa-user', NULL, NULL, NULL, NULL, 1, N'Users')
INSERT [dbo].[tblMenu] ([MenuId], [Name], [ControllerName], [ActionName], [isParent], [ParentId], [FontAwesome], [CreatedBy], [CreatedDate], [EditBy], [EditDate], [isActive], [ElementId]) VALUES (6, N'Permissions', N'User', N'RolesPermission', 0, 4, N'fa fa-key', NULL, NULL, NULL, NULL, 1, N'Roles')
SET IDENTITY_INSERT [dbo].[tblMenu] OFF
GO
SET IDENTITY_INSERT [dbo].[tblRole] ON 

INSERT [dbo].[tblRole] ([RoleId], [Role], [CreatedBy], [CreatedDate], [EditBy], [EditDate], [isActive]) VALUES (1, N'Admin', NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[tblRole] OFF
GO
SET IDENTITY_INSERT [dbo].[tblUser] ON 

INSERT [dbo].[tblUser] ([UserId], [username], [LastName], [FirstName], [Email], [Password], [RoleId], [CreatedBy], [CreatedDate], [EditBy], [EditDate], [isActive]) VALUES (1, N'admin', N'Admin ', N'Admin', N'admin@gmail.com', N'YWRtaW4=', 1, NULL, NULL, 1, CAST(N'2022-06-28T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tblUser] ([UserId], [username], [LastName], [FirstName], [Email], [Password], [RoleId], [CreatedBy], [CreatedDate], [EditBy], [EditDate], [isActive]) VALUES (3, N'asad', N'Bilal', N'Asad', N'asad@gmail.com', N'YXNhZA==', 1, 1, CAST(N'2022-06-28T00:00:00.000' AS DateTime), 3, CAST(N'2022-06-28T00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tblUser] OFF
GO
ALTER TABLE [dbo].[tblAccessLevel]  WITH CHECK ADD  CONSTRAINT [FK_AccessManu] FOREIGN KEY([MenuId])
REFERENCES [dbo].[tblMenu] ([MenuId])
GO
ALTER TABLE [dbo].[tblAccessLevel] CHECK CONSTRAINT [FK_AccessManu]
GO
ALTER TABLE [dbo].[tblAccessLevel]  WITH CHECK ADD  CONSTRAINT [FK_AccessRole] FOREIGN KEY([RoleId])
REFERENCES [dbo].[tblRole] ([RoleId])
GO
ALTER TABLE [dbo].[tblAccessLevel] CHECK CONSTRAINT [FK_AccessRole]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_CreatedByUserUser] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_CreatedByUserUser]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_EditByUserUser] FOREIGN KEY([EditBy])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_EditByUserUser]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_tblUser_tblRole] FOREIGN KEY([RoleId])
REFERENCES [dbo].[tblRole] ([RoleId])
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_tblUser_tblRole]
GO
USE [master]
GO
ALTER DATABASE [FloorPlans] SET  READ_WRITE 
GO
