import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsView extends GetView {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC4DBF6),
      appBar: AppBar(
        backgroundColor: Color(0xFF90e0ef),
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _buildSectionTitle('Welcome to ThriftSansar'),
          _buildParagraph(
            'ThriftSansar is your go-to platform for buying and selling pre-loved clothing items. We are passionate about creating a sustainable and inclusive fashion community where everyone can participate in reducing waste and giving new life to clothing.',
          ),
          const SizedBox(height: 20.0),
          _buildSectionTitle('Our Mission'),
          _buildParagraph(
            'At ThriftSansar, our mission is to promote sustainability through a circular economy. We encourage the reuse and resale of clothing items to reduce the environmental impact of fast fashion.',
          ),
          const SizedBox(height: 20.0),
          _buildSectionTitle('What We Offer'),
          _buildParagraph(
            'Explore a curated collection of quality secondhand clothing, from trendy fashion pieces to timeless classics. Sell your pre-loved items with ease and join our community of conscious consumers.',
          ),
          const SizedBox(height: 20.0),
          _buildSectionTitle('Our Vision'),
          _buildParagraph(
            'We envision ThriftSansar as a platform that goes beyond commerce. Our vision is to build a vibrant community centered around sustainable fashion, diversity, and empathy.',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
      ),
    );
  }
}
